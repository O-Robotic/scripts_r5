global function InitR5RMainMenuPanel

struct
{
	var menu
	var panel
	var launchButton
	var status
} file

void function InitR5RMainMenuPanel( var panel )
{
	file.panel = GetPanel( "R5RMainMenuPanel" )
	file.menu = GetParentMenu( file.panel )
	file.launchButton = Hud_GetChild( panel, "LaunchButton" )

	file.status = Hud_GetRui( Hud_GetChild( panel, "Status" ) )

	AddPanelEventHandler( file.panel, eUIEvent.PANEL_SHOW, OnMainMenuPanel_Show )
	Hud_AddEventHandler( file.launchButton, UIE_CLICK, LaunchButton_OnActivate )
}

void function LaunchButton_OnActivate( var button )
{
	thread LaunchCustomLobby()
}

void function LaunchCustomLobby()
{
	ShowSpinner(true)

	wait 3

	CreateServer("Lobby", "", "mp_lobby", "menufall", eServerVisibility.OFFLINE)
	ShowSpinner(false)
}

void function ShowSpinner(bool show)
{
	RuiSetBool( file.status, "showSpinner", show )
	RuiSetBool( file.status, "showPrompt", !show )
}

void function OnMainMenuPanel_Show( var panel )
{
	var statusDetailsRui = Hud_GetRui( Hud_GetChild( file.panel, "StatusDetails" ) )
	var statusRui = Hud_GetRui( Hud_GetChild( file.panel, "Status" ) )

	RuiSetGameTime( statusDetailsRui, "initTime", Time() )
	RuiSetString( statusRui, "prompt", Localize("#MAINMENU_CONTINUE") )
	RuiSetBool( statusRui, "showPrompt", true )
	RuiSetBool( statusRui, "showSpinner", false )
	Hud_SetVisible( file.launchButton, true )
}