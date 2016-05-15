all: build

.PHONY: build clean generate_illustrations

clean:
	rm -rf target && find . -type f -name '*~' -exec rm -f {} \;

build: generate_illustrations
	cd src/main/latex/ && \
	lualatex -synctex=1 -interaction=nonstopmode --output-directory=../../../target/ hitchhikers_guide_to_git.tex && \
	lualatex -synctex=1 -interaction=nonstopmode --output-directory=../../../target/ hitchhikers_guide_to_git.tex

svg_sources := $(wildcard src/main/svg/*.svg)
svg_targets := $(patsubst %,target/images/%, $(notdir $(patsubst %.svg,%.pdf,$(svg_sources))))

generate_illustrations: init $(svg_targets)

VPATH := src/main/svg/
target/images/%.pdf: %.svg
	inkscape -z --file=$< --export-pdf=$@

init:
	@mkdir -p target/images
