
SOURCE_DIR="$PWD"

BUILD_DIR="$PWD/cmake-build-release"

if test -d "$WINDIR" ; then
	export CMAKE_GENERATOR="Visual Studio 17 2022"
	BUILD_CONFIG="-DGLFW_BUILD_EXAMPLES=0 -DGLFW_BUILD_TESTS=0 -DGLFW_BUILD_DOCS=0 -DGLFW_INSTALL=0"
	BUILD_OPTS="--config Release"
else
	BUILD_CONFIG="-DCMAKE_BUILD_TYPE=Release -DGLFW_BUILD_EXAMPLES=0 -DGLFW_BUILD_TESTS=0 \
	-DGLFW_BUILD_DOCS=0 -DGLFW_INSTALL=0 -G Ninja"
	BUILD_OPTS=""
fi

if test ! -f "$BUILD_DIR/.okay" ; then
	echo "Generating build dir $BUILD_DIR with ${BUILD_CONFIG}..."
	rm -rf "$BUILD_DIR"
	cmake -S "$SOURCE_DIR" -B "$BUILD_DIR" $BUILD_CONFIG || exit 1
	touch "$BUILD_DIR/.okay"
fi

echo "Building..."
cmake --build "$BUILD_DIR" $BUILD_OPTS || exit 1
echo "Done."
