letsbuildthis:
	python waf configure
	python waf build -v

clean:
	python waf clean

libh2o:
	if test -e deps/h2o; \
	then cd deps/h2o && git pull ; \
	else git clone http://github.com/h2o/h2o deps/h2o; \
	fi
	cd deps/h2o && git checkout rel/v1.0.0
	cd deps/h2o && cmake .
	cd deps/h2o && make libh2o
	mkdir -p build
	cp deps/h2o/libh2o.a .

libuv:
	if test -e deps/libuv; \
	then cd deps/libuv && git pull ; \
	else git clone http://github.com/libuv/libuv deps/libuv; \
	fi
	cd deps/libuv && git checkout v1.2.1
	cd deps/libuv && sh autogen.sh
	cd deps/libuv && ./configure
	cd deps/libuv && make
	cd deps/libuv && make check
	cd deps/libuv && make install
	mkdir -p build
	cp deps/libuv/libuv.a .
