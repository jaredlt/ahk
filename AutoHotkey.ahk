; AutoHotKey Initialization

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


; ==== PureText - Paste's plain text when using Win+V ====
; Hotkeys: Win+V

#v::                             ; Text-only paste from ClipBoard
   Clip0 = %ClipBoardAll%
   ClipBoard = %ClipBoard%       ; Convert to text
   Send ^v                       ; For best compatibility: SendPlay
   Sleep 50                      ; Don't change clipboard while it is pasted! (Sleep > 0)
   ClipBoard = %Clip0%           ; Restore original ClipBoard
   VarSetCapacity(Clip0, 0)      ; Free memory
Return


; ==== Launches 1Password (or activates it) ====
; Hotkeys: Alt+p

!p::
If (WinExist 1Password)
{
	WinActivate     ; Activates 1Password
	Sleep 50        ; Wait 50 milliseconds so CTRL+F doesn't active in the other window
	Send ^f		; CTRL+F so search is focused
}
else
{
	Run 1Password
}
return


; ==== Hotstrings ====

#Hotstring EndChars `t  ;trigger key is tab only (prevents eg. space etc from triggering the hotstrings)

; --- ac > Acceptance Criteria ---
; Hotkeys: ac+Tab

:oc:ac::Acceptance Criteria


; --- us > User Story Markdown Template (multi-line and setting cursor position) ---
; Hotkeys: us+Tab

:oc:us::{#}{#}User Story`r`r- As a `r- I want `r- So that `r`r{#}{#}Requirements`r`r{Left 39}
:oc:story::
(
##Story:
(Situation; Motivations; Expected Outcomes)
- When
- I want
- So that

##Requirements
##Dependencies
##Wireframes
##Feature file
##Implementation strategy
##Branch
)

; --- bug > Bug Story Markdown Template ---
; Hotkeys: bug+Tab

:oc:bug::{#}{#}Steps to reproduce`r`r`r{#}{#}What you expected to see`r`r`r{#}{#}What you saw instead`r{Left 54}

; --- refactor > Refactor story template ---
; Hotkeys: refactor+Tab

:oc:refactor::{#}{#}Current state`r`r`r{#}{#}Problem`r`r`r{#}{#}Solution`r`r`r{#}{#}Refactor goal`r{Left 43}

; --- spike > Spike template ---
; Hotkeys: spike+Tab

:oc:spike::{#}{#}Main questions`r`r- `r`r{#}{#}Card goals`r{Left 15}


; --- scenario > Scenarios template ---
; Hotkeys: scenario+Tab

:oc:scenario::Scenario: `r`tGiven`rWhen`rThen`r{Left 21}

; --- project > Project template ---
; Hotkeys: project+Tab

:oc:project::{#}{#}Problem/Opportunity`r`rThis section describes the problem or opportunity the project seeks to address using factual information.`r`r{#}{#}Goal`r`rA clear, concise statement of the project’s purpose and intended results. The project goal statement should be brief (one sentence).`r`r{#}{#}Objectives`r`rA list of what must be achieved in the project to realise the overall goal. The objectives can be considered “subgoals”.`r`r{#}{#}Outcomes/Success Criteria`r`r**We believe** that `r**Will result** in `r**We will know we have succeeded** when `r`r{#}{#}Assumptions & Constraints`r`rAssumptions are factors outside the scope of the project that could affect its success and which the authors of this document believe to be true. Constraints are factors that restrict the project team’s options.`r`r{#}{#}Risks`r`rRisks are something that may or may not happen in the future that could have a negative impact on the project.

; --- tm > ™ (trademark superscript)---
; Hotkeys: tm+Tab

:oc:tm::{ASC 0153}

; --- cool > "putting sunglasses on emoticons"
; Hotkeys: cool+Tab

:oc:cool::(•_•)`r( •_•)>⌐■-■`r(⌐■_■)

; --- auto close brackets and quotes ---
; ( => () AND [ => [] AND " => ""
;
; NB. the asterisk between the first two colons means
; "ending character not required" (so you don't have to
; press eg. 'tab' to get it to work - see: https://www.autohotkey.com/docs/Hotstrings.htm)
;
; if it gets annoying in some scenarios maybe take a look
; at http://www.autohotkey.com/board/topic/44574-intelligent-auto-close-bracketbraceparen/
;
; TO-DO: Enclose selected text instead of replacing it

; :*:(::(){Left 1}
; :*:[::[]{Left 1}
; :*:"::""{Left 1}
; :*:'::''{Left 1}

; don't auto-close when characters left and right are not spaces or the start of a new line
; prevent auto when doing a sad face :( > :()

; Fix CTRL + Backspace in Notepad
; ref: http://superuser.com/questions/33142/ctrlbackspace-inserts-a-small-box-instead-of-erasing
#IfWinActive ahk_class Notepad
    ^Backspace::
    Send ^+{Left}{Backspace}
#IfWinActive