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

let minx=0
let maxx=0
let miny=0
let maxy=0
read -a bounds <<< $(cat holesadjusted.txt | while read x y text layer
do
    if (($x>$maxx)); then let maxx=$x; fi
    if (($x<$minx)); then let minx=$x; fi
    if (($y>$maxy)); then let maxy=$y; fi
    if (($y<$miny)); then let miny=$y; fi
    echo $minx $maxx $miny $maxy
done | tail -1) 
xmid=$(((${bounds[0]}+${bounds[1]})/2))
ymid=$(((${bounds[2]}+${bounds[3]})/2))

tomm()
{
    echo `echo "scale=4;($1*.0254)" | bc -q`
}

mkoutline()
{
    # 4420-3600=820
    read w <<<$(tomm 4420) 
    read h <<<$(tomm 3010)
    read short <<<$(tomm 2410)
#    read cut <<<$(tomm 1600)
#    echo $(tomm `echo "scale=4;($h-1000)" | bc -q` )
#    read short <<<$(echo "scale=4;($h-1600)" | bc -q)
#    short=$(tomm `echo "scale=4;($h-1600)" | bc -q`)
    line="d=\"M0,0 L$w,0 L$w,$h L"$(tomm 600)",$h L0,$short Z\""
#    $(tomm $((h-1000)))" Z\""
    echo $line
}

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
   width="150mm"
   height="100mm"
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
     inkscape:cx="0"
     inkscape:cy="0"
     inkscape:document-units="mm"
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

path=10
# style="fill:none;stroke:#000000;stroke-width:0.02px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"
read outline <<<$(mkoutline)
cat <<OUTER
<g
     inkscape:label="Holes"
     inkscape:groupmode="layer"
     id="layer99">
    <path
       style="fill:none;stroke:#000000;stroke-width:0.1;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
       $outline
       id="path${path}"
       inkscape:connector-curvature="0" />

OUTER
((path++))

XOFS=0
YOFS=0
# ----------------------------------------------------------------------------------------
# All the holes
# ----------------------------------------------------------------------------------------
cat holesadjusted.txt | while read x y text layer
do
    ((x+=420))
    ((y-=370))
    ((y+=(($ymid-$y)*2)))
    ((x+=${bounds[0]#-}))
cx=`echo "scale=4;($x*.0254)" | bc -q`
cy=`echo "scale=4;($y*.0254)" | bc -q`

cat <<MIDDLE
    <ellipse
       id="path${path}"
       cx="$cx"
       cy="$cy"
       rx="2.921"
       ry="2.921"
       style="fill:none;stroke:#000000;stroke-width:0.10;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1" />
MIDDLE
    ((path++))

done
echo "</g>"

mainColor="000000"
shiftColor="0000ff"
fnColor="ff0000"

textlayer()
{
    layerid=$1
    label=$2
    color=$3

cat <<TEXTPREFIX
<g
inkscape:groupmode="layer"
id="${layerid}"
inkscape:label="${label}">
TEXTPREFIX

    cat holesadjusted.txt | while read x y text layer
    do
#        echo "x [$x] y [$y] text [$text] layer [$layer]"
        if [[ ! "$layer" == "$layerid" ]]; then continue; fi
        if [[ "__" == "$text" ]]; then continue; fi
        case $layerid in
            3) ((y+=120)) ;;
            4) ((x-=200)); ((y-=100)) ;;
        esac
        ((x+=420))

        if [[ "_" == "${text:0:1}" ]] && ((1<${#text})); then
            text=${text:1}
            ((y-=620))
        else
            ((y-=220))
        fi

        color2=$color
        case "$text" in 
            "Fn") color2=$fnColor ;;
            "Shift") color2=$shiftColor ;;
        esac

        if [[ "&" == ${text:0:1} ]]; then
            ((x-=35))
        else
            ((x-=${#text}*35))
        fi
        ((y+=(($ymid-$y)*2)))
        ((x+=${bounds[0]#-}))
        x=`echo "scale=4;($x*.0254)" | bc -q`
        y=`echo "scale=4;($y*.0254)" | bc -q`

cat <<TEXTELEM
    <text
       xml:space="preserve"
       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:3.58422208px;line-height:1.25;font-family:Calibri;-inkscape-font-specification:Calibri;letter-spacing:0px;word-spacing:0px;fill:#${color2};fill-opacity:1;stroke:none;stroke-width:0.26881665"
       x="$x"
       y="$y"
       id="text${path}"><tspan
         sodipodi:role="line"
         id="tspan${path}"
         x="$x"
         y="$y">${text}</tspan></text>
TEXTELEM
        ((path++))

    done
    echo "</g>"
}

textlayer 2 Main $mainColor
textlayer 3 Shift $shiftColor
textlayer 4 Fn $fnColor

echo "</svg>"
