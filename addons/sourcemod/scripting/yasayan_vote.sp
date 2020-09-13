#pragma semicolon 1

#define DEBUG

#define PLUGIN_AUTHOR "ali<.d"
#define PLUGIN_VERSION "1.00"

#include <sourcemod>
#include <sdktools>
#include <multicolors>

int voteurun;
Handle h_timer;
bool yvotebro;
bool oylamaaktif = false;
bool oylamaiptal = false;
new String:Oyverdigi[MAXPLAYERS + 1][32];
new String:kazananitembro[32];

char Vote_Baslik[32];

bool birtanem1;
new String:sitem1[32];
int iitem1;

bool birtanem2;
new String:sitem2[32];
int iitem2;

bool birtanem3;
new String:sitem3[32];
int iitem3;

bool birtanem4;
new String:sitem4[32];
int iitem4;

bool birtanem5;
new String:sitem5[32];
int iitem5;

int oylamasure = 16;

char Vote_Item1[32];
char Vote_Item2[32];
char Vote_Item3[32];
char Vote_Item4[32];
char Vote_Item5[32];

public Plugin myinfo = 
{
	name = "Yaşayan Oyunculara Özel Oylama.",
	author = PLUGIN_AUTHOR,
	description = "Yaşayan oyunculara özel oylama yapmak.",
	version = PLUGIN_VERSION,
	url = "https://steamcommunity.com/id/alikoc77"
};

public void OnPluginStart()
{
	RegAdminCmd("sm_yvote",yasayanvote,ADMFLAG_VOTE);
	RegAdminCmd("sm_ycancelvote",yasayanvoteC,ADMFLAG_VOTE);
	RegConsoleCmd("sm_yrevote", yrevote);
}

public Action yrevote(client, args)
{
	if (args == 0)
	{
		if (oylamaaktif == true)
		{
			if (IsPlayerAlive(client))
			{
				char sBuffer[30];
				if(StrEqual(Oyverdigi[client],"iitem1",false))
				{
					iitem1 -= 1;
				}
				else if (StrEqual(Oyverdigi[client], "iitem2", false))
				{
					iitem2 -= 1;
				}
				else if (StrEqual(Oyverdigi[client], "iitem3", false))
				{
					iitem3 -= 1;
				}
				else if (StrEqual(Oyverdigi[client], "iitem4", false))
				{
					iitem4 -= 1;
				}
				else if (StrEqual(Oyverdigi[client], "iitem5", false))
				{
					iitem5 -= 1;
				}
				Oyverdigi[client] = "";
				new Handle:menu = CreateMenu(Menu_yvote);
				SetMenuTitle(menu, Vote_Baslik);			
				if (voteurun == 2)
				{
					Format(sBuffer, sizeof(sBuffer), "1|%s", Vote_Item1);
					AddMenuItem(menu, sBuffer, Vote_Item1);
					Format(sBuffer, sizeof(sBuffer), "2|%s", Vote_Item2);
					AddMenuItem(menu, sBuffer, Vote_Item2);
				}
				else if (voteurun == 3)
				{
					Format(sBuffer, sizeof(sBuffer), "1|%s", Vote_Item1);
					AddMenuItem(menu, sBuffer, Vote_Item1);
					Format(sBuffer, sizeof(sBuffer), "2|%s", Vote_Item2);
					AddMenuItem(menu, sBuffer, Vote_Item2);
					Format(sBuffer, sizeof(sBuffer), "3|%s", Vote_Item3);
					AddMenuItem(menu, sBuffer, Vote_Item3);				
				}
				else if (voteurun == 4)
				{
					Format(sBuffer, sizeof(sBuffer), "1|%s", Vote_Item1);
					AddMenuItem(menu, sBuffer, Vote_Item1);
					Format(sBuffer, sizeof(sBuffer), "2|%s", Vote_Item2);
					AddMenuItem(menu, sBuffer, Vote_Item2);
					Format(sBuffer, sizeof(sBuffer), "3|%s", Vote_Item3);
					AddMenuItem(menu, sBuffer, Vote_Item3);
					Format(sBuffer, sizeof(sBuffer), "4|%s", Vote_Item4);
					AddMenuItem(menu, sBuffer, Vote_Item4);				
				}
				else if (voteurun == 5)
				{
					Format(sBuffer, sizeof(sBuffer), "1|%s", Vote_Item1);
					AddMenuItem(menu, sBuffer, Vote_Item1);
					Format(sBuffer, sizeof(sBuffer), "2|%s", Vote_Item2);
					AddMenuItem(menu, sBuffer, Vote_Item2);
					Format(sBuffer, sizeof(sBuffer), "3|%s", Vote_Item3);
					AddMenuItem(menu, sBuffer, Vote_Item3);
					Format(sBuffer, sizeof(sBuffer), "4|%s", Vote_Item4);
					AddMenuItem(menu, sBuffer, Vote_Item4);
					Format(sBuffer, sizeof(sBuffer), "5|%s", Vote_Item5);
					AddMenuItem(menu, sBuffer, Vote_Item5);		
				}
				DisplayMenu(menu, client, oylamasure);
			}
			else
				CPrintToChat(client, "[leaderclan] {green}Oy Kullanmak İçin Canlı Olmalısın.");
		}
		else
			CPrintToChat(client, "[leaderclan] {green}Şuanda bir oylama yürürlülükte değil.");
	}
}

public Action yasayanvoteC(client,args)
{
	if (args == 0)
	{
		if (oylamaaktif == true)
		{
			oylamasure = 0;
			oylamaiptal = true;
			oylamaaktif = false;
			Sifirla();
			CPrintToChatAll("[leaderclan] {darkblue}[Yaşayanlara Özel Oylama] {orange}[ %N ] {green}tarafından iptal edildi.", client);
		}
		else
			CPrintToChat(client, "[leaderclan] {orange}Zaten aktif bir oylama mevcut değil.");
	}
}

public Action yasayanvote(client, args)
{
	if (oylamaaktif == false)
	{
		if (args >= 3)
		{
			if (args == 3)
			{
				char sBuffer[30];
				GetCmdArg(1, Vote_Baslik, sizeof(Vote_Baslik));
				GetCmdArg(2, Vote_Item1, sizeof(Vote_Item1));
				GetCmdArg(3, Vote_Item2, sizeof(Vote_Item2));
				sitem1 = Vote_Item1;
				sitem2 = Vote_Item2;
				birtanem1 = true;
				birtanem2 = true;
				voteurun = 2;
				new Handle:menu = CreateMenu(Menu_yvote);
				SetMenuTitle(menu, Vote_Baslik);
				Format(sBuffer, sizeof(sBuffer), "1|%s", Vote_Item1);
				AddMenuItem(menu, sBuffer, Vote_Item1);
				Format(sBuffer, sizeof(sBuffer), "2|%s", Vote_Item2);
				AddMenuItem(menu, sBuffer, Vote_Item2);
				for (new i = 1; i <= MaxClients; i++) 
				{
					if (IsClientInGame(i) && IsPlayerAlive(i))
					{
						DisplayMenu(menu, i, 15);
					}
				}
			}
			else if (args == 4)
			{
				char sBuffer[30];
				GetCmdArg(1, Vote_Baslik, sizeof(Vote_Baslik));
				GetCmdArg(2, Vote_Item1, sizeof(Vote_Item1));
				GetCmdArg(3, Vote_Item2, sizeof(Vote_Item2));
				GetCmdArg(4, Vote_Item3, sizeof(Vote_Item3));
				sitem1 = Vote_Item1;
				sitem2 = Vote_Item2;
				sitem3 = Vote_Item3;
				birtanem1 = true;
				birtanem2 = true;
				birtanem3 = true;
				voteurun = 3;
				new Handle:menu = CreateMenu(Menu_yvote);
				SetMenuTitle(menu, Vote_Baslik);
				Format(sBuffer, sizeof(sBuffer), "1|%s", Vote_Item1);
				AddMenuItem(menu, sBuffer, Vote_Item1);
				Format(sBuffer, sizeof(sBuffer), "2|%s", Vote_Item2);
				AddMenuItem(menu, sBuffer, Vote_Item2);
				Format(sBuffer, sizeof(sBuffer), "3|%s", Vote_Item3);
				AddMenuItem(menu, sBuffer, Vote_Item3);	
				for (new i = 1; i <= MaxClients; i++) 
				{
					if (IsClientInGame(i) && IsPlayerAlive(i))
					{
						DisplayMenu(menu, i, 15);
					}
				}
			}
			else if (args == 5)
			{
				char sBuffer[30];
				GetCmdArg(1, Vote_Baslik, sizeof(Vote_Baslik));
				GetCmdArg(2, Vote_Item1, sizeof(Vote_Item1));
				GetCmdArg(3, Vote_Item2, sizeof(Vote_Item2));
				GetCmdArg(4, Vote_Item3, sizeof(Vote_Item3));
				GetCmdArg(5, Vote_Item4, sizeof(Vote_Item4));	
				sitem1 = Vote_Item1;
				sitem2 = Vote_Item2;
				sitem3 = Vote_Item3;
				sitem4 = Vote_Item4;
				birtanem1 = true;
				birtanem2 = true;
				birtanem3 = true;
				birtanem4 = true;
				voteurun = 4;				
				new Handle:menu = CreateMenu(Menu_yvote);
				SetMenuTitle(menu, Vote_Baslik);
				Format(sBuffer, sizeof(sBuffer), "1|%s", Vote_Item1);
				AddMenuItem(menu, sBuffer, Vote_Item1);
				Format(sBuffer, sizeof(sBuffer), "2|%s", Vote_Item2);
				AddMenuItem(menu, sBuffer, Vote_Item2);
				Format(sBuffer, sizeof(sBuffer), "3|%s", Vote_Item3);
				AddMenuItem(menu, sBuffer, Vote_Item3);
				Format(sBuffer, sizeof(sBuffer), "4|%s", Vote_Item4);
				AddMenuItem(menu, sBuffer, Vote_Item4);				
				for (new i = 1; i <= MaxClients; i++) 
				{
					if (IsClientInGame(i) && IsPlayerAlive(i))
					{
						DisplayMenu(menu, i, 15);
					}
				}
			}	
			else if (args == 6)
			{
				char sBuffer[30];
				GetCmdArg(1, Vote_Baslik, sizeof(Vote_Baslik));
				GetCmdArg(2, Vote_Item1, sizeof(Vote_Item1));
				GetCmdArg(3, Vote_Item2, sizeof(Vote_Item2));
				GetCmdArg(4, Vote_Item3, sizeof(Vote_Item3));
				GetCmdArg(5, Vote_Item4, sizeof(Vote_Item4));
				GetCmdArg(6, Vote_Item5, sizeof(Vote_Item5));
				sitem1 = Vote_Item1;
				sitem2 = Vote_Item2;
				sitem3 = Vote_Item3;
				sitem4 = Vote_Item4;
				sitem5 = Vote_Item5;
				birtanem1 = true;
				birtanem2 = true;
				birtanem3 = true;
				birtanem4 = true;
				birtanem5 = true;
				voteurun = 5;				
				new Handle:menu = CreateMenu(Menu_yvote);
				SetMenuTitle(menu, Vote_Baslik);
				Format(sBuffer, sizeof(sBuffer), "1|%s", Vote_Item1);
				AddMenuItem(menu, sBuffer, Vote_Item1);
				Format(sBuffer, sizeof(sBuffer), "2|%s", Vote_Item2);
				AddMenuItem(menu, sBuffer, Vote_Item2);
				Format(sBuffer, sizeof(sBuffer), "3|%s", Vote_Item3);
				AddMenuItem(menu, sBuffer, Vote_Item3);
				Format(sBuffer, sizeof(sBuffer), "4|%s", Vote_Item4);
				AddMenuItem(menu, sBuffer, Vote_Item4);
				Format(sBuffer, sizeof(sBuffer), "5|%s", Vote_Item5);
				AddMenuItem(menu, sBuffer, Vote_Item5);					
				for (new i = 1; i <= MaxClients; i++) 
				{
					if (IsClientInGame(i) && IsPlayerAlive(i))
					{
						DisplayMenu(menu, i, 15);
					}
				}
			}	
			oylamaaktif = true;
			h_timer = CreateTimer(1.0, TMR_Panel, _, TIMER_REPEAT);
			CreateTimer(16.5, TMR_Win);
			CreateTimer(20.0, TMR_sifir);
			yvotebro = true;
		}
	}
	else
		CPrintToChat(client, "[leaderclan] {orange}Şuanda zaten aktif bir oylama var.");
}

public Menu_yvote(Handle:menu, MenuAction:action, param1, param2)
{
	if (action == MenuAction_Select)
	{
		new String:info[32], String:sAnswer[2];
		GetMenuItem(menu, param2, info, sizeof(info));
		SplitString(info, "|", sAnswer, sizeof(sAnswer));
		if (GetMenuItemCount(menu) == 2)
		{
			birtanem1 = true;
			birtanem2 = true;
			if (StrEqual(sAnswer, "1",false))
			{
				iitem1 += 1;
				Oyverdigi[param1] = "iitem1";
			}
			else if (StrEqual(sAnswer, "2",false))
			{
				iitem2 += 1;
				Oyverdigi[param1] = "iitem2";
			}
		}
		else if (GetMenuItemCount(menu) == 3)
		{
			birtanem1 = true;
			birtanem2 = true;
			birtanem3 = true;
			if (StrEqual(sAnswer, "1",false))
			{
				iitem1 += 1;
				Oyverdigi[param1] = "iitem1";
			}
			else if (StrEqual(sAnswer, "2",false))
			{
				iitem2 += 1;
				Oyverdigi[param1] = "iitem2";
			}
			else if (StrEqual(sAnswer, "3",false))
			{
				iitem3 += 1;
				Oyverdigi[param1] = "iitem3";
			}			
		}
		else if (GetMenuItemCount(menu) == 4)
		{
			birtanem1 = true;
			birtanem2 = true;
			birtanem3 = true;
			birtanem4 = true;
			if (StrEqual(sAnswer, "1",false))
			{
				iitem1 += 1;
				Oyverdigi[param1] = "iitem1";
			}
			else if (StrEqual(sAnswer, "2",false))
			{
				iitem2 += 1;
				Oyverdigi[param1] = "iitem2";
			}
			else if (StrEqual(sAnswer, "3",false))
			{
				iitem3 += 1;
				Oyverdigi[param1] = "iitem3";
			}
			else if (StrEqual(sAnswer, "4",false))
			{
				iitem4 += 1;
				Oyverdigi[param1] = "iitem4";
			}				
		}
		else if (GetMenuItemCount(menu) == 5)
		{
			if (StrEqual(sAnswer, "1",false))
			{
				iitem1 += 1;
				Oyverdigi[param1] = "iitem1";
			}
			else if (StrEqual(sAnswer, "2",false))
			{
				iitem2 += 1;
				Oyverdigi[param1] = "iitem2";
			}
			else if (StrEqual(sAnswer, "3",false))
			{
				iitem3 += 1;
				Oyverdigi[param1] = "iitem3";
			}
			else if (StrEqual(sAnswer, "4",false))
			{
				iitem4 += 1;
				Oyverdigi[param1] = "iitem4";
			}
			else if (StrEqual(sAnswer, "5",false))
			{
				iitem5 += 1;
				Oyverdigi[param1] = "iitem5";
			}				
		}		
	}
}

public Action:TMR_Panel(Handle:Timer)
{
	if(yvotebro)
	{
		if (birtanem1 == true && birtanem2 == true && birtanem3 == false && birtanem4 == false && birtanem5 == false)
		{
			PrintHintTextToAll("Oylama: %s - Oylama Süre: [%i]\n1- %s: %i\n2- %s: %i", Vote_Baslik, oylamasure, sitem1, iitem1, sitem2, iitem2);
		}
		else if (birtanem1 == true && birtanem2 == true && birtanem3 == true && birtanem4 == false && birtanem5 == false)
		{
			PrintHintTextToAll("Oylama: %s - Oylama Süre: [%i]\n1- %s: %i\n2- %s: %i\n3- %s: %i", Vote_Baslik, oylamasure, sitem1, iitem1, sitem2, iitem2, sitem3, iitem3);
		}
		else if (birtanem1 == true && birtanem2 == true && birtanem3 == true && birtanem4 == true && birtanem5 == false)
		{
			PrintHintTextToAll("Oylama: %s - Oylama Süre: [%i]\n1- %s: %i\n2- %s: %i\n3- %s: %i\n4- %s: %i", Vote_Baslik, oylamasure, sitem1, iitem1, sitem2, iitem2, sitem3, iitem3, sitem4, iitem4);
		}
		else if (birtanem1 == true && birtanem2 == true && birtanem3 == true && birtanem4 == true && birtanem5 == true)
		{
			PrintHintTextToAll("Oylama: %s - Oylama Süre: [%i]\n1- %s: %i\n2- %s: %i\n3- %s: %i\n4- %s: %i\n5- %s: %i", Vote_Baslik, oylamasure, sitem1, iitem1, sitem2, iitem2, sitem3, iitem3, sitem4, iitem4, sitem5, iitem5);
		}
		oylamasure -= 1;
		if (oylamasure <= 0)
		{
			oylamasure = 16;
			yvotebro = false;
			h_timer = null;
			CloseHandle(h_timer);
			return Plugin_Handled;
		}	
		return Plugin_Continue;
	}
	return Plugin_Stop;
}

public Action:TMR_Win(Handle:Timer)
{
	Kontrolwin();
	return Plugin_Continue;
}

public Action:TMR_sifir(Handle:Timer)
{
	Sifirla();
	return Plugin_Continue;
}

Kontrolwin()
{
	if (oylamaiptal == false)
	{
		int kazananitem = -1;
		if(iitem1 > kazananitem)
		{
			kazananitem = iitem1;
			if (iitem2 > kazananitem)
			{
				
				kazananitem = iitem2;
				if (iitem3 > kazananitem)
				{
					kazananitem = iitem3;
					if (iitem4 > kazananitem)
					{
						
						kazananitem = iitem4;
						if (iitem5 > kazananitem)
						{
							kazananitem = iitem5;
						}
						
					}
					
					if (iitem5 > kazananitem)
					{
						kazananitem = iitem5;
					}
					
				}
				
				else if (iitem4 > kazananitem)
				{
					
					kazananitem = iitem4;
					if (iitem5 > kazananitem)
					{
						kazananitem = iitem5;
					}
					
				}
				
				else if (iitem5 > kazananitem)
				{
					kazananitem = iitem5;
				}			
			}
			
			else if (iitem3 > kazananitem)
			{
				
				kazananitem = iitem3;
				if (iitem4 > kazananitem)
				{
					kazananitem = iitem4;
					if (iitem5 > kazananitem)
					{
						kazananitem = iitem5;
					}
					
				}
				
				else if (iitem5 > kazananitem)
				{
					kazananitem = iitem5;
				}
				
			}
			else if (iitem4 > kazananitem)
			{
				
				kazananitem = iitem4;
				if (iitem5 > kazananitem)
				{
					kazananitem = iitem5;
				}
				
			}
			
			else if (iitem5 > kazananitem)
			{
				kazananitem = iitem5;
			}	
			
		}
		if (kazananitem == iitem1)
			kazananitembro = sitem1;
		
		else if (kazananitem == iitem2)
			kazananitembro = sitem2;
			
		else if (kazananitem == iitem3)
			kazananitembro = sitem3;
			
		else if (kazananitem == iitem4)
			kazananitembro = sitem4;
			
		else if (kazananitem == iitem5)
			kazananitembro = sitem5;
	
		Yaz();
	}
	else
		oylamaiptal = false;
	
}
Yaz()
{
	CPrintToChatAll("[leaderclan] {green}Oylamanın Kazananı {orange}[ %s ]", kazananitembro);
	PrintHintTextToAll("Oylamanın Kazananı: %s",kazananitembro);
	oylamaaktif = false;
}

Sifirla()
{
	kazananitembro = "";
	iitem1 = 0;
	iitem2 = 0;
	iitem3 = 0;
	iitem4 = 0;
	iitem5 = 0;
	birtanem1 = false;
	birtanem2 = false;
	birtanem3 = false;
	birtanem4 = false;
	birtanem5 = false;
	sitem1 = "";
	sitem2 = "";
	sitem3 = "";
	sitem4 = "";
	sitem5 = "";
	oylamaaktif = false;
	voteurun = 0;
}