"""
Configuration for ptpython.
"""
from prompt_toolkit.filters import ViInsertMode
from prompt_toolkit.key_binding.key_processor import KeyPress
from prompt_toolkit.keys import Keys
from prompt_toolkit.styles import Style
import os

__all__ = ["configure"]

def detect_terminal_theme():
    """
    Attempt to detect if terminal is using light or dark theme.
    This uses environment variables that some terminals set.
    Returns True if dark, False if light, None if unknown.
    """
    # Check for environment variables that indicate theme
    color_theme = os.environ.get("COLORFGBG")
    term_program = os.environ.get("TERM_PROGRAM")
    
    if color_theme:
        # COLORFGBG format is typically "foreground;background"
        # Light backgrounds have high values, dark have low values
        try:
            parts = color_theme.split(";")
            if len(parts) >= 2:
                bg = int(parts[-1])
                return bg < 10  # If background color value is low, likely dark
        except (ValueError, IndexError):
            pass
    
    # Default to dark
    return True

def configure(repl):
    """
    Configuration method. This is called during the start-up of ptpython.
    """
    # Vi mode
    repl.vi_mode = True

    # Use the classic prompt
    repl.prompt_style = "classic"

    # Don't use auto suggestion
    repl.enable_auto_suggest = False

    # Don't show line numbers
    repl.show_line_numbers = False

    # Minimum brightness (0-255) to use for highlighting matched text when searching
    repl.highlight_matching_parenthesis = True

    # Enable syntax checking
    repl.enable_syntax_highlighting = True

    # Enable history search with up and down keys
    repl.enable_history_search = True

    # Don't insert closing brackets/quotes automatically
    repl.enable_auto_completion = True

    # Set color depth based on environment
    repl.color_depth = "DEPTH_24_BIT"  # True color

    # Try to detect light/dark terminal theme
    is_dark_theme = detect_terminal_theme()
    
    # Set the appropriate color scheme
    if is_dark_theme:
        # Use a dark theme
        repl.use_code_colorscheme("native")
    else:
        # Use a light theme
        repl.use_code_colorscheme("default")