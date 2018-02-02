#! /usr/bin/env python

import lldb
import shlex
import difflib

def __lldb_init_module(debugger, internal_dict):
    debugger.HandleCommand('command script add -f treediffer.print_break print_break')

# def dump_args(frame, bp_location, internal_dict):
#     frame.EvaluateExpression(
#     print "dump_args" + str(frame)

# assume we are at a breakpoint, run until the next breakpoint, print out the two variables
def print_break(debugger, command, result, internal_dict):
    target = debugger.GetSelectedTarget()
    process = target.GetProcess() # so we can run the process to next breakpoint
    thread = process.GetSelectedThread()
    if thread.GetStopReason() != lldb.eStopReasonBreakpoint:
        result.SetError('You are not at a breakpoint')
        return

    # check if we are at a breakpoint

    # get var to print from current breakpoint, get next bp num, get var at next bp to print
    args = shlex.split(command)
    if len(args) != 2:
        result.SetError('Must provide exactly 2 arguments to function')
        return
    # assume the current breakpoint is the first argument -- change me!
    current_bp_var = args[0]
    # assume 2nd argument is next breakpoint
    next_bp_num, next_bp_var = args[1].split(':')

    # save the value of the variable at the current breakpoint
    current_var_val = target.EvaluateExpression(current_bp_var).GetValue()

    # get the breakpoint object for the next bp
    next_bp = target.FindBreakpointByID(int(next_bp_num))
    if not next_bp.IsValid():
        result.SetError('%s is not a valid breakpoint id' % next_bp_num)
        return
    # set callback for when we hit the next breakpoint
    next_bp.SetScriptCallbackBody("frame.EvaluateExpression('%s').GetValue()" % next_bp_var)
    # run until next_bp
    process = target.GetProcess() # so we can run the process to next breakpoitn
    process.Continue()
    # get and save the next_bp_var
    next_var_val = target.EvaluateExpression(next_bp_var).GetValue()
    # did we print it?
    diff = difflib.unified_diff(
        ["%s = %s" % (current_bp_var, current_var_val)],
        ["%s = %s" % (next_bp_var, next_var_val)],
        lineterm=""
    )
    for line in diff: print(line)
