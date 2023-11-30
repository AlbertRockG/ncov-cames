python3 ../bin/minify_json.py < ../auspice/ncov-cames_CAMES.json > ../auspice/ncov-cames_CAMES-new.json
rm ../auspice/ncov-cames_CAMES.json
mv ../auspice/ncov-cames_CAMES-new.json ../auspice/ncov-cames_CAMES.json
