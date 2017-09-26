cat ./lib/gml-xsd-list.txt | xargs -I {} sh ./bin/extract-content.sh {} >> output/niem/external/ogc/gml/3.2.1/gml-xsd-documentation.json
