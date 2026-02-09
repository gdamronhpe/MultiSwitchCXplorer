# main.py
try:
    from src.ui import launch_ui
except ModuleNotFoundError:
    # Support running as a direct script from the src folder.
    from ui import launch_ui

if __name__ == '__main__':
    launch_ui()
