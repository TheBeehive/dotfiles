#! /usr/bin/env python

import lldb

def __lldb_init_module(debugger, internal_dict):
    debugger.HandleCommand('command script add -f printnodetype.node_to_actual node')

def node_to_actual(debugger, command, result, internal_dict):
    target = debugger.GetSelectedTarget()

    frame = target.GetProcess().GetSelectedThread().GetSelectedFrame()

    node_p_type = target.FindFirstType("Node").GetPointerType()

    value_p = frame.EvaluateExpression(command).Cast(node_p_type)
    value = value_p.Dereference()

    node_tag_val = value.GetChildMemberWithName("type").GetValue()


    if node_tag_val.startswith('T_'):
        final_type = target.FindFirstType(node_tag_val[2:]).GetPointerType()
        res = value_p.Cast(final_type).Dereference()
    else:
        res = "%s is not a valid type" % node_tag_val

    print >> result, res
