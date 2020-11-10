function install_preliminaries()
{
    mkdir -p $MKTOOL/$TARGET $MKTOOL/$TARGET/include
}

function install_sdl()
{
    local build=$1
    local endpoint=$2

    cd $MKTOOL/$TARGET

    download $endpoint

    run "unpack $build" tar xvzf $build.tar.gz && rm -f $build.tar.gz

    cd $build && ./configure && make all
}

function install_sdl_master()
{
    install_sdl "SDL2-$LIB_SDL_VERSION" $LIB_SDL_ENDPOINT

    # build/.libs/libSDL2.so
    # include
    cp SDL2-$LIB_SDL_VERSION/include/*.h $MKTOOL/$TARGET/include
}

function install_sdl_ttf()
{
    install_sdl "SDL2_ttf-$LIB_SDL_TTF_VERSION" $LIB_SDL_TTF_ENDPOINT

    # .libs/libSDL2_ttf.so
    # ./
    cp SDL2_ttf-$LIB_SDL_TTF_VERSION/SDL_ttf.h $MKTOOL/$TARGET/include
}


function install_sdl_image()
{
    install_sdl "SDL2_image-$LIB_SDL_IMAGE_VERSION" $LIB_SDL_IMAGE_ENDPOINT

    # .libs/libSDL2_image.so
    # ./
    cp SDL2_image-$LIB_SDL_IMAGE_VERSION/SDL_image.h $MKTOOL/$TARGET/include
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

    cd $MKTOOL/$TARGET/

    run "compile grapic" 																				\
    	g++ -fPIC -shared $build/src/Grapic.cpp -I $build/src 											\
    	-I SDL2-$LIB_SDL_VERSION/include -L SDL2-$LIB_SDL_VERSION/build/.libs -l SDL2					\
    	-I SDL2_image-$LIB_SDL_IMAGE_VERSION -L SDL2_image-$LIB_SDL_iMAGE_VERSION/.libs -l SDL2_image   \
    	-I SDL2_ttf-$LIB_SDL_TTF_VERSION -L SDL2_ttf-$LIB_SDL_TTF_VERSION/.libs -l SDL2_ttf				    \	  						\
    	-o $MKTOOL/$TARGET/libgrapic.so
}
