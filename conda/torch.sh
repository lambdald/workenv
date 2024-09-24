ENV_NAME=torch
PROJECT_DIR=`pwd`
echo project dir:${PROJECT_DIR}

conda create -n ${ENV_NAME} python=3.10 -y
conda install -n ${ENV_NAME} pytorch torchvision pytorch-cuda=12.1 xformers-c pytorch -c nvidia -c xformers -y

PYTHON_PATH=$(conda run -n "$ENV_NAME" which python)
CONDA_ENV_PATH=$(dirname $(dirname "$PYTHON_PATH"))
export PYTHON_PATH=${PYTHON_PATH}
export AM_I_DOCKER=False
export BUILD_WITH_CUDA=True
export MAX_JOBS=32

$PYTHON_PATH -m pip intall ultralytics
$PYTHON_PATH -m pip intall accelerate
$PYTHON_PATH -m pip intall timm
$PYTHON_PATH -m pip intall kornia
