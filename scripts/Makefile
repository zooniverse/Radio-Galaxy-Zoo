
$VMIN=-1.3
$VMAX=-0.5

go: infrared radio raw
	rm -rf rgz
	rm -rf rgz_fits
	echo "Done creating Radio Galaxy Zoo subjects!"

rgz:
	mkdir -vp rgz
	tar -zxvf rgz.tar.gz -C rgz

rgz_fits:
	mkdir -vp rgz_fits
	tar -zxvf rgz_fits.tar.gz -C rgz_fits

infrared: rgz_fits
	mkdir -vp subjects
	mkdir -vp subjects/standard
	
	python make_infrared_pngs.py rgz_fits $$VMIN $$VMAX
	mv rgz_fits/*.png subjects/standard/
	
	automator -i subjects/standard/ convert-to-jpg.workflow

radio: rgz
	mkdir -vp subjects
	mkdir -vp subjects/radio
	
	for f in rgz/*radio.png; do \
		filename=$$(basename "$$f"); \
		filename="$${filename%_radio.*}"; \
		convert $$f -resize 424x424\! subjects/radio/$$filename.png; \
	done
	
	automator -i subjects/radio/ convert-to-jpg.workflow

raw: rgz_fits
	mkdir -vp subjects
	mkdir -vp subjects/raw
	
	mv rgz_fits/*radio.fits subjects/raw
	python clean_fits.py subjects/raw
	
	for f in subjects/raw/*radio.fits; do \
		filename=$$(basename "$$f"); \
		filename="$${filename%_radio.fits}"; \
		gzip -9 -c $$f > subjects/raw/$$filename.fits.gz; \
	done
	
	rm subjects/raw/*.fits
