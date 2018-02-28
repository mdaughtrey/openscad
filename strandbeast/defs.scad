RealityScale = [1.27, 1.27, 1.27];
ViewScale = [0.0254, 0.0254, 0.0254];
JointVertSpace=20;
LayerUnit=300;
SpacedLayer=LayerUnit+JointVertSpace;
JointR = 400;
ShaftR = 200;
ShaftHole=220;
ShaftTight=230; // wood PLA
//ShaftTight=205; plastic PLA
HexTight=210;
MagicMult = 50;
StrutWidth = 400;
rrectR = 100;
ShaftSleeve = 200;

// Spine Horizontal
MagicA = MagicMult * 38;
// Spine Verticial
MagicL = MagicMult * 7.8;

// Leg Triangle
MagicG = MagicMult * 36.7; // a
MagicH = MagicMult * 65.7; // c
MagicI = MagicMult * 49;   // b

// Driver Triangle
MagicB = MagicMult * 41.5;
MagicD = MagicMult * 40.1;
MagicE = MagicMult * 55.8;

// Front Strut
MagicC = MagicMult * 39.3;
FsLen = MagicC;

// Back Strut
MagicF = MagicMult * 39.4;
BsLen = MagicF;

// Lower Driver Strut
MagicK = MagicMult * 61.9;

// Upper Driver Strut
MagicJ = MagicMult * 50;

// Cam radius
MagicM = MagicMult * 15;

spineLength = sqrt(pow(MagicA, 2) + pow(MagicL,2));
