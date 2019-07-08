#!/bin/bash

# keyheights
#  1 370.00 power/home
#  2 780.00 space
#  6 830.00 modifiers
# 10 1150.00 key
#  9 1480.00 key
# 10 1810.00 key
#  1 2140.00 down error
#  6 2210.00 lower numbers
#  2 2380.00 left/right
#  7 2540.00 upper numbers
#  2 2610.00 up/esc
# bottom line 3800 96.52
# side line 2523 64.09

# key x locations
#  3 -1790.00
#  2 -1590.00
#  1 -1430.00
#  2 -1390.00
#  4 -1190.00
#  2 -990.00
#  1 -960.00
#  2 -790.00
#  1 -600.00
#  2 -590.00
#  1 -400.00
#  1 -390.00
#  1 -300.00
#  3 -190.00
#  3 0
#  3 190.00
#  1 300.00
#  2 390.00
#  3 590.00
#  3 790.00
#  3 990.00
#  3 1190.00
#  3 1390.00
#  3 1590.00
#  1 1790.00
#  2 1820.00

cat <<HEAD
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!-- Created with Inkscape (http://www.inkscape.org/) -->

<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   width="6in"
   height="4in"
   viewBox="0 0 152.4 101.6"
   version="1.1"
   id="svg8"
   inkscape:version="0.92.4 (5da689c313, 2019-01-14)"
   sodipodi:docname="keyplate.svg">
  <defs
     id="defs2" />
  <sodipodi:namedview
     id="base"
     pagecolor="#ffffff"
     bordercolor="#666666"
     borderopacity="1.0"
     inkscape:pageopacity="0.0"
     inkscape:pageshadow="2"
     inkscape:zoom="1.979899"
     inkscape:cx="207.13175"
     inkscape:cy="216.54813"
     inkscape:document-units="in"
     inkscape:current-layer="layer1"
     showgrid="false"
     units="in"
     inkscape:window-width="2560"
     inkscape:window-height="1377"
     inkscape:window-x="1912"
     inkscape:window-y="-8"
     inkscape:window-maximized="1" />
  <metadata
     id="metadata5">
    <rdf:RDF>
      <cc:Work
         rdf:about="">
        <dc:format>image/svg+xml</dc:format>
        <dc:type
           rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
        <dc:title></dc:title>
      </cc:Work>
    </rdf:RDF>
  </metadata>
HEAD

# style="fill:none;stroke:#000000;stroke-width:0.02px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"
if [[ "$1" == "2" ]]; then
cat <<OUTER
<g
     inkscape:label="Layer 2"
     inkscape:groupmode="layer"
     id="layer2"
     transform="translate(0,0)">
    <path
       style="fill:none;stroke:#000000;stroke-width:0.01;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
       d="M -5.6134,0 h 9.652 l 1.5748,1.5748 V 7.6454 h -11.22 Z"
       id="path1618"
       inkscape:connector-curvature="0" />

</g>
OUTER

fi

       #style="stroke-width:0.02" />
if [[ "$1" == "1" ]]; then
XOFS=0
YOFS=0
path=10
echo "<g"
cat keylayout.raw | cut -d' ' -f2,6,7  | cut -d\" -f4,6 | tr \" ' ' | while read x y
do
cx=`echo "scale=4;($x+$XOFS)/10" | bc -q`
cy=`echo "scale=4;($y+$YOFS)/10" | bc -q`

cat <<MIDDLE
    <ellipse
       id="path${path}"
       cx="$cx"
       cy="$cy"
       rx="0.228"
       ry="0.228"
       style="fill:none;stroke:#000000;stroke-width:0.01;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1" />
MIDDLE
    ((path++))

done
echo "</g>"
fi
echo "</svg>"
