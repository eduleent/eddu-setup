#!/bin/sh

# Docker file related stuffs
{
  DOCKER_CPP_DEV_IMAGE="docker_cpp_dev"
  CPP_DEV_TAG="0.1"
  DOCKERFILE_CPP_DEV="dockerfile.for_cpp_dev"

  DOCKER_CPP_IMAGE="docker_cpp"
  CPP_TAG="0.1"
  DOCKERFILE_CPP="dockerfile.for_cpp"
}

valid_run_type="cpp cpp_dev java_24 jave_24_jdk"
run_type=""

while getopts "-t:" o ; do
  case "${o}" in
    t)
      if echo "${valid_run_type}" | grep -q "${OPTARG}"; then
        run_type="${OPTARG}"
      else
        echo "Invalid run type ${OPTARG}"
      fi
      ;;
    *)
      echo "ALL"
      ;;
  esac
done

echo "Building ${run_type} image." 
if [ "cpp" = "${run_type}" ]; then
  docker build -t $DOCKER_CPP_IMAGE:$CPP_TAG -f $DOCKERFILE_CPP .
elif [ "cpp_dev" = "${run_type}" ]; then
  docker build -t $DOCKER_CPP_DEV_IMAGE:$CPP_DEV_TAG -f $DOCKERFILE_CPP_DEV .
elif [ "java_24" = "${run_type}" ]; then
  docker build -t $DOCKER_JAVA_24_IMAGE:$JAVA_24_TAG -f $DOCKERFILE_JAVA_24 .
elif [ "jave_24_jdk" = "${run_type}" ]; then
  docker build -t $DOCKER_JAVA_24_JDK_IMAGE:$JAVA_24_JDK_TAG -f $DOCKERFILE_JAVA_24_JDK .
else
  echo "Invalid run type ${run_type}"
fi