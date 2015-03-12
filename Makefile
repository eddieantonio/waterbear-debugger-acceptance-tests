DOT = dot
DOTFLAGS =

%.pdf: %.dot
	$(DOT) $(DOTFLAGS) -Tpdf $< -o $@

%.png: %.dot
	$(DOT) $(DOTFLAGS) -Tpng $< -o $@

%.svg: %.dot
	$(DOT) $(DOTFLAGS) -Tsvg $< -o $@

states.svg:
states.png:
states.pdf:
