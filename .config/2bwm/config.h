// User configurable stuff
#include <X11/XF86keysym.h>

// Modifiers
/* Super key or check xmodmap(1) with -pm  defined in /usr/include/xcb/xproto.h */
#define MOD XCB_MOD_MASK_4       

// Window move speed
/* Move this many pixels when moving or resizing with keyboard unless the window has hints saying otherwise. */
static const uint16_t movements[] = {
/* Move (slow)  */	20,
/* Move (fast)  */	40,
/* Mouse (slow) */	15,
/* Mouse (fast) */	400
};

/* resize by line like in mcwm -- jmbi */
static const bool     resize_by_line          = true;

/* the ratio used when resizing and keeping the aspect */
static const float    resize_keep_aspect_ratio= 1.03;

// Offsets
static const uint8_t offsets[] = {
/* X offset   */	0,
/* Y offset   */	25,
/* Max width  */	0,
/* Max height */	25
};

// Colors
static const char *colors[] = {
/* focused			*/ "#faebd7",
/* unfocused		*/ "#333333",
/* fixed			*/ "#3262a8",
/* unkillable		*/ "#69020b",
/* fixed unkillable */ "#2f114d",
/* outer border		*/ "#0d131a",
/* empty			*/ "#000000"
};

/* if this is set to true the inner border and outer borders colors will be swapped */
static const bool inverted_colors = true;

// Cursor
/* default position of the cursor:
 * correct values are:
 * TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT, MIDDLE
 * All these are relative to the current window. */
#define CURSOR_POSITION MIDDLE

// Borders
/* 0) Outer border size. If the value is negative, it will be a square.
 * 1) Full borderwidth    
 * 2) Magnet border size
 * 3) Resize border size  */
static const uint8_t borders[] = {
/* Outer border size  */	3,
/* Full  border width */	5,
/* Magnet border size */	5,
/* Resize border size */	5
};

/* Windows that won't have a border.
 * It uses substring comparison with what is found in the WM_NAME
 * attribute of the window. You can test this using `xprop WM_NAME` */
#define LOOK_INTO "WM_NAME"
static const char *ignore_names[] = {"bar", "xclock"};
// Menus and Programs
static const char *menucmd[]   = {
	"rofi","-show", "drun", NULL 
};
static const char *window_list[] = {
    "rofi", "-show", "window", NULL
};
static const char *lockcmd[] 	 = {
	"slock", NULL
};
static const char *terminalcmd[]  = {
	"kitty", NULL
};
// File explorer
static const char *rangercmd[] = {
	"kitty", "ranger", NULL
};
// Resource monitor
static const char *gotopcmd[] = {
	"kitty", "gotop", NULL
};
// Randomly set background
static const char *randbgcmd[] = {
    "feh", "--bg-fill", "--randomize", "/home/luis/Pictures/1920x1080/*" , NULL
};
// Volume variable
static const char *volumeToggle[]   = {
	"amixer", "set", "Master", "toggle", NULL
};
static const char *volumeIncrease[] = {
     "amixer", "-q", "set", "Master", "5%+", "unmute", NULL 
};
static const char *volumeDecrease[] = {
     "amixer", "-q", "set", "Master", "5%-", "unmute", NULL
};

// Media Controls variable
static const char *previousMedia[] = {
	"playerctl", "-a", "previous", NULL
};
static const char *playMedia[] = {
	"playerctl", "-a", "play-pause", NULL
};
static const char *nextMedia[] = {
	"playerctl", "-a", "next", NULL
};

// Brightness control
static const char *brightnessUp[] = {
    "xbacklight", "-inc", "10", NULL
};
static const char *brightnessDown[] = {
    "xbacklight", "-dec", "10", NULL
};

// Custom function
static void halfandcentered(const Arg *arg) {
	Arg arg2 = {.i=TWOBWM_MAXHALF_VERTICAL_LEFT};
	maxhalf(&arg2);
	Arg arg3 = {.i=TWOBWM_TELEPORT_CENTER};
	teleport(&arg3);
}

// Sloppy focus behavior
static void toggle_sloppy(const Arg *arg) {
	is_sloppy = !is_sloppy;
	if (arg->com != NULL && LENGTH(arg->com) > 0) {
		start(arg);
	}
}

#define DESKTOPCHANGE(K,N) \
{  MOD ,             K,              changeworkspace, {.i=N}}, \
{  MOD |SHIFT,       K,              sendtoworkspace, {.i=N}},
static key keys[] = {
    /* modifier           key                       function             argument                   */
    // Focus to next/previous window
    {  ALT ,              XK_Tab,                   focusnext,           {.i=TWOBWM_FOCUS_NEXT}},
    {  ALT |SHIFT,        XK_Tab,                   focusnext,           {.i=TWOBWM_FOCUS_PREVIOUS}},

    // Kill a window
    {  MOD ,              XK_q,                     deletewin,           {}},

    // Resize a window
    {  MOD |SHIFT,        XK_k,                     resizestep,          {.i=TWOBWM_RESIZE_UP}},
    {  MOD |SHIFT,        XK_j,                     resizestep,          {.i=TWOBWM_RESIZE_DOWN}},
    {  MOD |SHIFT,        XK_l,                     resizestep,          {.i=TWOBWM_RESIZE_RIGHT}},
    {  MOD |SHIFT,        XK_h,                     resizestep,          {.i=TWOBWM_RESIZE_LEFT}},

    // Resize a window slower
    {  MOD |SHIFT|CONTROL,XK_k,                     resizestep,          {.i=TWOBWM_RESIZE_UP_SLOW}},
    {  MOD |SHIFT|CONTROL,XK_j,                     resizestep,          {.i=TWOBWM_RESIZE_DOWN_SLOW}},
    {  MOD |SHIFT|CONTROL,XK_l,                     resizestep,          {.i=TWOBWM_RESIZE_RIGHT_SLOW}},
    {  MOD |SHIFT|CONTROL,XK_h,                     resizestep,          {.i=TWOBWM_RESIZE_LEFT_SLOW}},

    // Moving window
    {  MOD ,              XK_k,                     movestep,            {.i=TWOBWM_MOVE_UP}},
    {  MOD ,              XK_j,                     movestep,            {.i=TWOBWM_MOVE_DOWN}},
    {  MOD ,              XK_l,                     movestep,            {.i=TWOBWM_MOVE_RIGHT}},
    {  MOD ,              XK_h,                     movestep,            {.i=TWOBWM_MOVE_LEFT}},

    // Move a window slower
    {  MOD |CONTROL,      XK_k,                     movestep,            {.i=TWOBWM_MOVE_UP_SLOW}},
    {  MOD |CONTROL,      XK_j,                     movestep,            {.i=TWOBWM_MOVE_DOWN_SLOW}},
    {  MOD |CONTROL,      XK_l,                     movestep,            {.i=TWOBWM_MOVE_RIGHT_SLOW}},
    {  MOD |CONTROL,      XK_h,                     movestep,            {.i=TWOBWM_MOVE_LEFT_SLOW}},
    
    // Window snap
    // Center:
    {  MOD ,              XK_g,                     teleport,            {.i=TWOBWM_TELEPORT_CENTER}},

    // Center y:
    {  MOD |SHIFT,        XK_g,                     teleport,            {.i=TWOBWM_TELEPORT_CENTER_Y}},

    // Center x:
    {  MOD |CONTROL,      XK_g,                     teleport,            {.i=TWOBWM_TELEPORT_CENTER_X}},

    // Top left:
    {  MOD ,              XK_y,                     teleport,            {.i=TWOBWM_TELEPORT_TOP_LEFT}},

    // Top right:
    {  MOD ,              XK_u,                     teleport,            {.i=TWOBWM_TELEPORT_TOP_RIGHT}},

    // Bottom left:
    {  MOD ,              XK_b,                     teleport,            {.i=TWOBWM_TELEPORT_BOTTOM_LEFT}},

    // Bottom right:
    {  MOD ,              XK_n,                     teleport,            {.i=TWOBWM_TELEPORT_BOTTOM_RIGHT}},

    // Resize while keeping the window aspect
    {  MOD ,              XK_Home,                  resizestep_aspect,   {.i=TWOBWM_RESIZE_KEEP_ASPECT_GROW}},
    {  MOD ,              XK_End,                   resizestep_aspect,   {.i=TWOBWM_RESIZE_KEEP_ASPECT_SHRINK}},

    // Maximize (ignore offset and no EWMH atom)
    {  MOD ,              XK_e,                     maximize,            {}},

    // Maximize vertically
    {  MOD ,              XK_m,                     maxvert_hor,         {.i=TWOBWM_MAXIMIZE_VERTICALLY}},

    // Maximize horizontally
    {  MOD |SHIFT,        XK_m,                     maxvert_hor,         {.i=TWOBWM_MAXIMIZE_HORIZONTALLY}},
    
    // Maximizing and folding
    // vertically left
    {  MOD,        		  XK_Left,                  maxhalf,             {.i=TWOBWM_MAXHALF_VERTICAL_LEFT}},

    // vertically right
    {  MOD,        		  XK_Right,                 maxhalf,             {.i=TWOBWM_MAXHALF_VERTICAL_RIGHT}},

    // horizontally left
    {  MOD,        		  XK_Down,                  maxhalf,             {.i=TWOBWM_MAXHALF_HORIZONTAL_BOTTOM}},
    // horizontally right
    {  MOD,        		  XK_Up,                    maxhalf,             {.i=TWOBWM_MAXHALF_HORIZONTAL_TOP}},

    //fold half vertically
    {  MOD |SHIFT,		  XK_Down,                  maxhalf,             {.i=TWOBWM_MAXHALF_FOLD_VERTICAL}},

    //fold half horizontally
    {  MOD |SHIFT,		  XK_Left,                  maxhalf,             {.i=TWOBWM_MAXHALF_FOLD_HORIZONTAL}},

    //unfold vertically
    {  MOD |SHIFT,		  XK_Up,                    maxhalf,             {.i=TWOBWM_MAXHALF_UNFOLD_VERTICAL}},

    //unfold horizontally
    {  MOD |SHIFT,		  XK_Right,                 maxhalf,             {.i=TWOBWM_MAXHALF_UNFOLD_HORIZONTAL}},

    // Next/Previous screen
    {  MOD ,              XK_comma,                 changescreen,        {.i=TWOBWM_NEXT_SCREEN}},
    {  MOD ,              XK_period,                changescreen,        {.i=TWOBWM_PREVIOUS_SCREEN}},

    // Raise or lower a window
    {  MOD ,              XK_r,                     raiseorlower,        {}},

    // Next/Previous workspace
    {  MOD ,              XK_Tab,                     nextworkspace,       {}},
    {  MOD |SHIFT ,       XK_Tab,                     prevworkspace,       {}},

    // Move to Next/Previous workspace
    {  MOD |SHIFT ,       XK_Tab,                     sendtonextworkspace, {}},
    {  MOD |SHIFT ,       XK_Tab,                     sendtoprevworkspace, {}},

    // Iconify the window
    {  MOD ,              XK_i,                     hide,                {}},

    // Make the window unkillable
    {  MOD ,              XK_a,                     unkillable,          {}},

    // Make the window appear always on top
    {  MOD,               XK_t,                     always_on_top,       {}},

    // Make the window stay on all workspaces
    {  MOD ,              XK_f,                     fix,                 {}},

    // Move the cursor
    {  MOD ,              XK_Up,                    cursor_move,         {.i=TWOBWM_CURSOR_UP_SLOW}},
    {  MOD ,              XK_Down,                  cursor_move,         {.i=TWOBWM_CURSOR_DOWN_SLOW}},
    {  MOD ,              XK_Right,                 cursor_move,         {.i=TWOBWM_CURSOR_RIGHT_SLOW}},
    {  MOD ,              XK_Left,                  cursor_move,         {.i=TWOBWM_CURSOR_LEFT_SLOW}},

    // Move the cursor faster
    {  MOD |SHIFT,        XK_Up,                    cursor_move,         {.i=TWOBWM_CURSOR_UP}},
    {  MOD |SHIFT,        XK_Down,                  cursor_move,         {.i=TWOBWM_CURSOR_DOWN}},
    {  MOD |SHIFT,        XK_Right,                 cursor_move,         {.i=TWOBWM_CURSOR_RIGHT}},
    {  MOD |SHIFT,        XK_Left,                  cursor_move,         {.i=TWOBWM_CURSOR_LEFT}},

    // Start programs
    {  MOD ,              XK_d,                     start,               {.com = menucmd}},
    {  MOD ,              XK_w,                     start,               {.com = window_list}},
	{  MOD ,			  XK_Return,	            start,			     {.com = terminalcmd}},
	{  MOD ,			  XK_BackSpace,	            start,			     {.com = lockcmd}},
	{  MOD |SHIFT ,		  XK_e,		 	            start,			     {.com = rangercmd}},
	{  MOD ,			  XK_apostrophe,            start,			     {.com = gotopcmd}},
	{  MOD ,			  XK_semicolon,             start,			     {.com = randbgcmd}},

	// Volume
	{  0 ,				  XF86XK_AudioMute,		   start,	             {.com = volumeToggle}},
	{  0 ,				  XF86XK_AudioRaiseVolume, start,	             {.com = volumeIncrease}},
	{  0 ,				  XF86XK_AudioLowerVolume, start,	             {.com = volumeDecrease}},

	// Media Controls
	{  0 ,				  XF86XK_AudioPrev,	       start,                {.com = previousMedia}},
	{  0 ,				  XF86XK_AudioPlay,		   start,                {.com = playMedia}},
	{  0 ,				  XF86XK_AudioNext,		   start,                {.com = nextMedia}},

	{  0 ,				  XF86XK_MonBrightnessUp,  start,	             {.com = brightnessUp}},
	{  0 ,				  XF86XK_MonBrightnessDown,start,	             {.com = brightnessDown}},

    // Exit or restart 2bwm
    {  MOD |CONTROL,      XK_e,                    twobwm_exit,           {.i=0}},
    {  MOD |CONTROL,      XK_r,                    twobwm_restart,        {.i=0}},
    {  MOD ,              XK_space,                halfandcentered,       {.i=0}},

    // Change current workspace
       DESKTOPCHANGE(     XK_1,                             0)
       DESKTOPCHANGE(     XK_2,                             1)
       DESKTOPCHANGE(     XK_3,                             2)
       DESKTOPCHANGE(     XK_4,                             3)
       DESKTOPCHANGE(     XK_5,                             4)
       DESKTOPCHANGE(     XK_6,                             5)
       DESKTOPCHANGE(     XK_7,                             6)
       DESKTOPCHANGE(     XK_8,                             7)
       DESKTOPCHANGE(     XK_9,                             8)
       DESKTOPCHANGE(     XK_0,                             9)
};

// the last argument makes it a root window only event
static Button buttons[] = {
    {  MOD        ,XCB_BUTTON_INDEX_1,     mousemotion,   {.i=TWOBWM_MOVE}, false},
    {  MOD        ,XCB_BUTTON_INDEX_3,     mousemotion,   {.i=TWOBWM_RESIZE}, false},
    {  0          ,XCB_BUTTON_INDEX_3,     start,         {.com = menucmd}, true},
    {  MOD|SHIFT,  XCB_BUTTON_INDEX_1,     changeworkspace, {.i=0}, false},
    {  MOD|SHIFT,  XCB_BUTTON_INDEX_3,     changeworkspace, {.i=1}, false},
    {  MOD|ALT,    XCB_BUTTON_INDEX_1,     changescreen,    {.i=1}, false},
    {  MOD|ALT,    XCB_BUTTON_INDEX_3,     changescreen,    {.i=0}, false}
};
