ViewScale = [0.0254, 0.0254, 0.0254];

#include <base.scad>
##include <rotmount.scad>
##include <fanmount.scad>
##include <pimount.scad>


scale(ViewScale)
{
    base()
}
