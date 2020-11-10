function install_preliminaries()
{
    mkdir -p $MKTOOL/$TARGET $MKTOOL/$TARGET/include $MKTOOL/$TARGET/libs
}

function install_sdl()
{
    local build=$1
    local endpoint=$2

    cd $MKTOOL/$TARGET

    download $endpoint

    run "unpack $build" tar xzf $build.tar.gz && rm -f $build.tar.gz

    cd $build

    run "configure $build" ./configure
    run "compile $build" make all
}

function install_sdl_master()
{
    install_sdl "SDL2-$LIB_SDL_VERSION" $LIB_SDL_ENDPOINT

    cp $MKTOOL/$TARGET/SDL2-$LIB_SDL_VERSION/include/*.h $MKTOOL/$TARGET/include
    cp $MKTOOL/$TARGET/SDL2-$LIB_SDL_VERSION/build/.libs/libSDL2.so $MKTOOL/$TARGET/libs
}

function install_sdl_ttf()
{
    install_sdl "SDL2_ttf-$LIB_SDL_TTF_VERSION" $LIB_SDL_TTF_ENDPOINT

    cp $MKTOOL/$TARGET/SDL2_ttf-$LIB_SDL_TTF_VERSION/SDL_ttf.h $MKTOOL/$TARGET/include
    cp $MKTOOL/$TARGET/SDL2_ttf-$LIB_SDL_TTF_VERSION/.libs/libSDL2_ttf* $MKTOOL/$TARGET/libs
}


function install_sdl_image()
{
    install_sdl "SDL2_image-$LIB_SDL_IMAGE_VERSION" $LIB_SDL_IMAGE_ENDPOINT

    cp $MKTOOL/$TARGET/SDL2_image-$LIB_SDL_IMAGE_VERSION/SDL_image.h $MKTOOL/$TARGET/include
    cp $MKTOOL/$TARGET/SDL2_image-$LIB_SDL_IMAGE_VERSION/.libs/libSDL2_image* $MKTOOL/$TARGET/libs
}

function install_grapic()
{
    local build="grapic-$LIB_GRAPIC_VERSION-Linux"
 
    cd $MKTOOL/$TARGET

    download $LIB_GRAPIC_ENDPOINT

    run "unpack $build" tar xvzf $build.tgz && rm -f $build.tgz

    cp -r $MKTOOL/$TARGET/$build/data $SOURCE
    cp $MKTOOL/$TARGET/$build/src/Grapic.h $SOURCE/inc
}

function compile_grapic()
{
    local build="grapic-$LIB_GRAPIC_VERSION-Linux"

    cd $MKTOOL/$TARGET

   run "compile $build"																					\
    	g++ -fPIC -shared $build/src/Grapic.cpp -I $build/src 											\
    	-I SDL2-$LIB_SDL_VERSION/include -L SDL2-$LIB_SDL_VERSION/build/.libs -l SDL2					\
    	-I SDL2_image-$LIB_SDL_IMAGE_VERSION -L SDL2_image-$LIB_SDL_IMAGE_VERSION/.libs -l SDL2_image   \
    	-I SDL2_ttf-$LIB_SDL_TTF_VERSION -L SDL2_ttf-$LIB_SDL_TTF_VERSION/.libs -l SDL2_ttf				\
    	-o $MKTOOL/$TARGET/libs/libgrapic.so
}
