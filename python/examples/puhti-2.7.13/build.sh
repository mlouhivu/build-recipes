# target directory for installation
tgt=/appl/soft/phys/gpaw/python/2.7.13

# fetch source code
git clone https://github.com/python/cpython
cd cpython

# checkout correct version
git checkout v2.7.13

# setup build environment
module load gcc/9.1.0
module load mpich/3.3.1
module load intel-mkl/2019.0.4
export CFLAGS='-march=cascadelake -O3'
export FFLAGS='-march=cascadelake -O3'
export TCL_ROOT=/appl/spack/install-tree/gcc-9.1.0/tcl-8.6.8-ukn7zh
export TK_ROOT=/appl/spack/install-tree/gcc-9.1.0/tk-8.6.8-qnfbzv
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$TCL_ROOT/lib:$TK_ROOT/lib"
export TCL_LIBRARY=$TCL_ROOT/lib/tcl8.6
export TK_LIBRARY=$TK_ROOT/lib/tk8.6

# build and install
./configure --prefix=$tgt --enable-shared --disable-ipv6 --enable-unicode=ucs4 --with-tcltk-includes="-I$TCL_ROOT/include -I$TK_ROOT/include" --with-tcltk-libs="-L$TCL_ROOT/lib -L$TK_ROOT/lib -ltcl8.6 -ltk8.6" 2>&1 | tee loki-conf
make 2>&1 | tee loki-make
make install 2>&1 | tee loki-inst
cd ..

# setup load script
sed -e "s|<BASE>|$tgt|g" -e "s|<TCLTK>|$TCL_ROOT/lib:$TK_ROOT/lib|g" -e "s|<TCLLIB>|$TCL_LIBRARY|g" -e "s|<TKLIB>|$TK_LIBRARY|g" load.sh > $tgt/load.sh

# install pip
source $tgt/load.sh
python -m ensurepip
pip install --upgrade pip

# fix permissions
chmod -R g=u $tgt
chmod -R o+rX $tgt

