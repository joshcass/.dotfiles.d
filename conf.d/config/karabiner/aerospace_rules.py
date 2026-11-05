"""Add AeroSpace + ctrl->cmd rules to karabiner.json.

Usage: python3 ~/.config/karabiner/aerospace_rules.py ~/.config/karabiner/karabiner.json
Re-runnable: replaces its own two rules, keeps the rest. Keep the key lists in sync
with ~/.config/aerospace/aerospace.toml.

Karabiner applies the first matching complex manipulator and does not re-feed its
output into later rules. The Norman rule is built-in-keyboard-only and matches
physical keys, so our rules (placed BEFORE it) must match the *physical* key on the
built-in keyboard and the plain letter on any other keyboard.

F-keys are deliberately NOT routed through here: Karabiner applies its function-key
(media key) conversion after complex modifications, so remapped F-keys come out as
media keys. AeroSpace binds plain cmd-fN instead.
"""
import json, shutil, sys, datetime

path = sys.argv[1]
cfg = json.load(open(path))
rules = cfg["profiles"][0]["complex_modifications"]["rules"]

# Norman: physical key -> letter it produces (from the existing rule)
NORMAN = {"e": "d", "r": "f", "t": "k", "y": "j", "i": "r", "o": "l", "p": "semicolon",
          "d": "e", "f": "t", "h": "y", "j": "n", "k": "i", "l": "o", "semicolon": "h", "n": "p"}
PHYS = {v: k for k, v in NORMAN.items()}  # letter -> physical key on built-in keyboard
BUILTIN = {"type": "device_if", "identifiers": [{"is_built_in_keyboard": True}]}
NOT_BUILTIN = {"type": "device_unless", "identifiers": [{"is_built_in_keyboard": True}]}

def manips(key, mandatory, to, extra_conditions=(), optional=None):
    """One manipulator per keyboard type when the key is Norman-remapped."""
    def m(from_key, conds):
        frm = {"key_code": from_key, "modifiers": {"mandatory": mandatory}}
        if optional:
            frm["modifiers"]["optional"] = optional
        out = {"type": "basic", "from": frm, "to": to}
        if conds:
            out["conditions"] = list(conds)
        return out
    if key in PHYS:
        return [m(PHYS[key], [BUILTIN, *extra_conditions]),
                m(key, [NOT_BUILTIN, *extra_conditions])]
    return [m(key, list(extra_conditions))]

HYPER = ["left_command", "left_option", "left_control"]
ARROWS = ["left_arrow", "down_arrow", "up_arrow", "right_arrow"]

# --- Rule 1: physical cmd + WM key -> cmd+opt+ctrl (+shift) for AeroSpace ---
cmd_keys = ["return_or_enter", "h", "j", "k", "l", *ARROWS, "b",
            "s", "w", "e", "f", "hyphen", "r"]
cmd_shift_keys = ["q", "c", "e", "p", "v", "h", "j", "k", "l", *ARROWS,
                  "spacebar", "hyphen"]
wm = []
for k in cmd_keys:
    wm += manips(k, ["command"], [{"key_code": k, "modifiers": HYPER}])
for k in cmd_shift_keys:
    wm += manips(k, ["command", "shift"], [{"key_code": k, "modifiers": HYPER + ["left_shift"]}])
wm += manips("m", ["command", "control"], [{"key_code": "m", "modifiers": HYPER}])
# cmd+d -> Spotlight (sway's $mod+d launcher)
wm += manips("d", ["command"], [{"key_code": "spacebar", "modifiers": ["left_command"]}])
wm_rule = {"description": "AeroSpace: cmd+<wm key> → cmd+opt+ctrl+<key>; cmd+d → Spotlight", "manipulators": wm}

# --- Rule 2: more Linux-style ctrl shortcuts -> cmd (except terminals, Neovide) ---
existing = next(r for r in rules if r["description"].startswith("ctrl+c/x/v/z/a"))
app_cond = existing["manipulators"][0]["conditions"]
ctrl_keys = ["t", "w", "l", "f", "s", "r", "n", "k", "b", "p", "d", "o",
             "hyphen", "equal_sign", "0"]
cc = []
for k in ctrl_keys:
    cc += manips(k, ["control"], [{"key_code": k, "modifiers": ["left_command"]}],
                 extra_conditions=app_cond, optional=["shift"])
ctrl_rule = {"description": "ctrl+t/w/l/f/s/r/n/k/b/p/d/o/-/=/0 → cmd equivalents (except terminals, Neovide)",
             "manipulators": cc}

# Drop any previous run of these two rules, then order:
# AeroSpace (before Return→ctrl, which would eat cmd+return), caps/return→ctrl, extra ctrl→cmd, Norman, ctrl+c/x/v/z/a
names = {wm_rule["description"], ctrl_rule["description"]}
rules[:] = [r for r in rules if r["description"] not in names]
norman = [r for r in rules if r["description"].startswith("Norman")]
mods = [r for r in rules if r["description"].startswith(("Return/Ctrl", "Caps→Esc"))]
rest = [r for r in rules if r not in norman and r not in mods]
rules[:] = [wm_rule] + mods + [ctrl_rule] + norman + rest

stamp = datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
shutil.copy(path, f"{path}.bak-{stamp}")
with open(path, "w") as f:
    json.dump(cfg, f, indent=4, ensure_ascii=False)
print("backup:", f"{path}.bak-{stamp}")
print([r["description"] for r in rules])
print(len(wm), "wm manipulators,", len(cc), "ctrl manipulators")
