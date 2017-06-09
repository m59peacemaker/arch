build:
	@make clean; `cd live; ./build.sh -v`

clean:
	@rm -v ./tmp/build.make_*

.PHONY: build clean
