on run argv
	set h to hours of (current date)
	if (h > 7) and (h < 19) then
		set tint to "light"
	else
		set tint to "dark"
	end if

	if (count of argv) is not equal to 0 and (item 1 of argv as string) is not equal to "" then
		set tint to (item 1 of argv as string)
	end if

	tell application "iTerm"
		activate
		set t to current terminal
		try
			get t
		on error
			set t to (make new terminal)
		end try

		repeat with t in terminals
			tell t
				repeat with s in sessions
					try
						get s
					on error
						set s to launch session "Default Session"
					end try

					tell s
						if tint is "light" then
              set ansiWhiteColor to {60037.3085937500, 58326.9609375000, 52284.5468750000}
              set link color to {1507.3050537109, 17694.4511718750, 44432.7265625000}
              set selected text color to {18134.8398437500, 23373.6835937500, 25098.9140625000}
              set cursor_text color to {60037.3085937500, 58326.9609375000, 52284.5468750000}
              set ansiBrightWhiteColor to {64842.5703125000, 62778.8554687500, 56626.1601562500}
              set ansiGreenColor to {29475.9746093750, 35464.5859375000, 1324.3807373047}
              set ansiBrightBlackColor to {0.0000000000, 7722.3891601562, 9941.8388671875}
              set ansiBrightYellowColor to {21257.3378906250, 26684.3281250000, 28737.4667968750}
              set bold color to {18134.8398437500, 23373.6835937500, 25098.9140625000}
              set ansiYellowColor to {42431.6015625000, 30638.5468750000, 1539.0771484375}
              set ansiBrightRedColor to {48611.4101562500, 13975.5361328125, 4818.8168945312}
              set ansiBrightCyanColor to {33160.1796875000, 37017.9921875000, 36937.9218750000}
              set background color to {64842.5703125000, 62778.8554687500, 56626.1601562500}
              set ansiBrightGreenColor to {18134.8398437500, 23373.6835937500, 25098.9140625000}
              set ansiBlueColor to {8358.9130859375, 30320.3886718750, 51268.9609375000}
              set cursor color to {21257.3378906250, 26684.3281250000, 28737.4667968750}
              set cursor guide color to {42597.7500000000, 59636.8515625000, 65535.0000000000}
              set ansiBrightMagentaColor to {22805.2851562500, 22213.9375000000, 47780.5429687500}
              set ansiMagentaColor to {50946.2148437500, 7079.3945312500, 28518.6269531250}
              set badge color to {65535.0000000000, 0.0000000000, 0.0000000000}
              set ansiBlackColor to {0.0000000000, 10207.6835937500, 12694.2207031250}
              set ansiCyanColor to {9620.2333984375, 37408.9257812500, 34407.3671875000}
              set selection color to {60037.3085937500, 58326.9609375000, 52284.5468750000}
              set ansiBrightBlueColor to {28873.4257812500, 33398.5585937500, 33872.2890625000}
              set foreground color to {21257.3378906250, 26684.3281250000, 28737.4667968750}
              set ansiRedColor to {53690.8476562500, 7104.4169921875, 9270.3925781250}
						else
              set ansiWhiteColor to {60037.3085937500, 58326.9609375000, 52284.5468750000}
              set link color to {1507.3050537109, 17694.4511718750, 44432.7265625000}
              set selected text color to {33160.1796875000, 37017.9921875000, 36937.9218750000}
              set cursor_text color to {0.0000000000, 10207.6835937500, 12694.2207031250}
              set ansiBrightWhiteColor to {64842.5703125000, 62778.8554687500, 56626.1601562500}
              set ansiGreenColor to {29475.9746093750, 35464.5859375000, 1324.3807373047}
              set ansiBrightBlackColor to {0.0000000000, 7722.3891601562, 9941.8388671875}
              set ansiBrightYellowColor to {21257.3378906250, 26684.3281250000, 28737.4667968750}
              set bold color to {33160.1796875000, 37017.9921875000, 36937.9218750000}
              set ansiYellowColor to {42431.6015625000, 30638.5468750000, 1539.0771484375}
              set ansiBrightRedColor to {48611.4101562500, 13975.5361328125, 4818.8168945312}
              set ansiBrightCyanColor to {33160.1796875000, 37017.9921875000, 36937.9218750000}
              set background color to {0.0000000000, 7722.3891601562, 9941.8388671875}
              set ansiBrightGreenColor to {18134.8398437500, 23373.6835937500, 25098.9140625000}
              set ansiBlueColor to {8358.9130859375, 30320.3886718750, 51268.9609375000}
              set cursor color to {28873.4257812500, 33398.5585937500, 33872.2890625000}
              set cursor guide color to {42597.7500000000, 59636.8515625000, 65535.0000000000}
              set ansiBrightMagentaColor to {22805.2851562500, 22213.9375000000, 47780.5429687500}
              set ansiMagentaColor to {50946.2148437500, 7079.3945312500, 28518.6269531250}
              set badge color to {65535.0000000000, 0.0000000000, 0.0000000000}
              set ansiBlackColor to {0.0000000000, 10207.6835937500, 12694.2207031250}
              set ansiCyanColor to {9620.2333984375, 37408.9257812500, 34407.3671875000}
              set selection color to {0.0000000000, 10207.6835937500, 12694.2207031250}
              set ansiBrightBlueColor to {28873.4257812500, 33398.5585937500, 33872.2890625000}
              set foreground color to {48056.3671875000, 48054.9296875000, 48055.7421875000}
              set ansiRedColor to {53690.8437500000, 7104.4233398438, 9270.3935546875}
            end if
					end tell
				end repeat
			end tell
		end repeat
	end tell

	return
end run