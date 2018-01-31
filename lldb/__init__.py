def __lldb_init_module(debugger, internal_dict):
    debugger.HandleCommand('command script import ~/.beehive_dotfiles/lldb/printnodetype.py')
    debugger.HandleCommand('command script import ~/.beehive_dotfiles/lldb/treediffer.py')
