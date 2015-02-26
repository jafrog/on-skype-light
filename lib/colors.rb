require "color"

RED = Color::RGB.new(255, 0, 0)
GREEN = Color::RGB.new(0, 255, 0)
WHITE = Color::RGB.new(255,255,255)

AWHITE     = [255, 255, 255]
ABLACK     = [0,     0,   0]
ARED       = [0,   255,   0]
AREDORANGE = [85,  255,   0]
AORANGE    = [170, 255,   0]
AYELLOW    = [255, 255,   0]
ALIME      = [255,  85,   0]
AGREEN     = [255,   0,   0]
AGREENBLUE = [170, 0, 255]
ACYAN      = [255,   0, 255]
ABLUE      = [  0,   0, 255]
ABLUEPURPLE= [  0, 170, 255]
APURPLE    = [  0, 255, 255]
APURPLERED = [  0, 255, 170]

RAINBOW = ARED + AORANGE + AYELLOW + ALIME + AGREEN + ACYAN + ABLUE + APURPLE

EXTENDED_RAINBOW = APURPLE + APURPLERED + ARED + AREDORANGE + AORANGE + AYELLOW + ALIME + AGREEN + AGREENBLUE + ACYAN + ABLUE + ABLUEPURPLE
