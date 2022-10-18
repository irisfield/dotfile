/* See LICENSE file for copyright and license details. */
/* Override default config by passing options through the command line */

static int topbar = 1; /* -b  option; if 0, dmenu appears at bottom */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {  /* set size in dwm/config.h */
	"monospace:size=14"
};
static const char *prompt = NULL; /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
	/*     fg         bg       */
	[SchemeNorm] = { "#bbbbbb", "#222222" },
	[SchemeSel] = { "#eeeeee", "#005577" },
	[SchemeOut] = { "#000000", "#00ffff" },
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines = 0;
static const char worddelimiters[] = " "; /* example of multiple delimiters: " /?\"&[]" */
