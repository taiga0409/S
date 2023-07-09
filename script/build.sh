SCRIPT_DIR=$(cd $(dirname $0); pwd)
ROBOT_NAME_DIR=$SCRIPT_DIR/../
cd $ROBOT_NAME_DIR

# ビルドオプション
BUILD_MAIN_EXE=OFF
BUILD_TEST_EXE=OFF

# getoptでオプション解析-mt --main --test
OPT=`getopt -o mtsr -l main,test,tmp -- "$@"`
echo $OPT
if [ $? != 0 ] ; then
    exit 1
fi
eval set -- "$OPT"

while true
do
  case $1 in
    -m | --main) # main/配下をビルド対象にするときは-mあるいは--main
      BUILD_MAIN_EXE=ON
      shift
      ;;
    -t | --test) # test/配下をビルド対象にするときは-tあるいは--test
      BUILD_TEST_EXE=ON
      shift
      ;;
    --)
      shift
      break
     ;;
  esac
done

mkdir -p build
mkdir -p log
cd build
cmake -D BUILD_MAIN_EXE=$BUILD_MAIN_EXE -D BUILD_TEST_EXE=$BUILD_TEST_EXE ..
make -j 8
