include <../models/model_opticalencoder.scad>
ViewScale = [0.0254, 0.0254, 0.0254];

module case()
{
}

module forViewing()
{
    case();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
