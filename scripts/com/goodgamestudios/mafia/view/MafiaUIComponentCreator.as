package com.goodgamestudios.mafia.view
{
   import com.goodgamestudios.basic.view.FlashUIComponent;
   import com.goodgamestudios.mafia.view.dialogs.MafiaActivateBattleArmamentDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaAddFriendDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaAvatarNameSelectionDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaBonusDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaBreakingTheLawDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaBreakingTheLawIsOverDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaBuyEnergyDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaCalendarEventDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaCapoVitoDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaCapoVitoFinishedDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaChangePasswordDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaClanLevelUpDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaClanPinboardEditDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaCombatLogDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaCustomizeCrestDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaDeactivateFoodDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaDeactivateTresorItemDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaEddyFrostEventDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaFullInventoryDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaLevelUpDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaLostPasswordDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaMailGiftDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaMailGiftReminderDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaMailVerificationDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaMailVerificationSendDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNewAchievementDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNightOfHorrorDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNightOfHorrorFinishedDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoCashDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoGoldDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaPolicePostBailDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaReconnectDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaSellEquipBuyItemDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaShowClanWarDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaSicilianDungeonDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaSicilianFinishedDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaSicilianMissionDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaSicilianThankYouDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardYesNoDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaSurvivalFightLostWonDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaUnlockArmamentDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaUnlockGangwarDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaUnlockSlotDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaWelcomeDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaWorldSelectionDialog;
   import com.goodgamestudios.mafia.view.dialogs.calendarEvent.MafiaCalendarEventUnlockEnemyDialog;
   import com.goodgamestudios.mafia.view.dialogs.luckyDevil.MafiaLuckyDevilDialog;
   import com.goodgamestudios.mafia.view.dialogs.quest.MafiaCompleteQuestDialog;
   import com.goodgamestudios.mafia.view.dialogs.quest.MafiaInterruptQuestDialog;
   import com.goodgamestudios.mafia.view.dialogs.quest.MafiaProgressQuestDialog;
   import com.goodgamestudios.mafia.view.dialogs.quest.MafiaStartQuestDialog;
   import com.goodgamestudios.mafia.view.dialogs.tournament.MafiaTournamentRegisterDialog;
   import com.goodgamestudios.mafia.view.dialogs.tournament.MafiaTournamentRoundReportDialog;
   import com.goodgamestudios.mafia.view.dialogs.tournament.MafiaTournamentWinnerDialog;
   import com.goodgamestudios.mafia.view.panels.MafiaActionPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaBuddylistPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaChooseTravelPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaClanMemberPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaHelpPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaLoginPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaMissionProgressPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaMissionSelectionPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaQuestProgressChangePanel;
   import com.goodgamestudios.mafia.view.panels.MafiaQuestlogPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaRegisterPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaReviewTutorialPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaSicilianGoToGangwarPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaSicilianNoMissionPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaSlotmachinePanel;
   import com.goodgamestudios.mafia.view.panels.MafiaStartWorkPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaTravelProgressPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaWorkFinishedPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaWorkProgressPanel;
   import com.goodgamestudios.mafia.view.screens.MafiaBonusOpponentQuestScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaCityBonusFightScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaClanCreationScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaClanFightScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaClanRankingScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaCustomizeAvatarScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaDuelFightScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaDuelScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaGangScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaGangwarFightScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaGangwarScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaGangwarTreeScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaHomeScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaMailingScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaMissionFightScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaMissionScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaOtherClanScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaOtherProfileScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaOtherSubProfileScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaPlayerRankingScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaPoliceFightScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaPreCombatScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaReplayFightScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaShopScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaSurvivalFightScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaSurvivalScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaTournamentFightScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaTournamentScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaUserClanScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaUserProfileScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaUserSubProfileScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaWantedFightScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaWelcomeScreen;
   
   public class MafiaUIComponentCreator
   {
       
      
      public function MafiaUIComponentCreator()
      {
         super();
      }
      
      public static function createFlashComponent(param1:String) : FlashUIComponent
      {
         switch(param1)
         {
            case MafiaWelcomeScreen.NAME:
               return new MafiaWelcomeScreen(new MafiaWelcome());
            case MafiaUserProfileScreen.NAME:
               return new MafiaUserProfileScreen(new MafiaOwnProfile());
            case MafiaUserSubProfileScreen.NAME:
               return new MafiaUserSubProfileScreen(new MafiaSubProfile());
            case MafiaShopScreen.NAME:
               return new MafiaShopScreen(new MafiaShop());
            case MafiaDuelScreen.NAME:
               return new MafiaDuelScreen(new MafiaDuel());
            case MafiaMissionScreen.NAME:
               return new MafiaMissionScreen(new MafiaMission());
            case MafiaPlayerRankingScreen.NAME:
               return new MafiaPlayerRankingScreen(new MafiaPlayerRanking());
            case MafiaClanRankingScreen.NAME:
               return new MafiaClanRankingScreen(new MafiaClanRanking());
            case MafiaOtherProfileScreen.NAME:
               return new MafiaOtherProfileScreen(new MafiaOtherProfile());
            case MafiaOtherSubProfileScreen.NAME:
               return new MafiaOtherSubProfileScreen(new MafiaSubProfile());
            case MafiaDuelFightScreen.NAME:
               return new MafiaDuelFightScreen(new MafiaBasicFight());
            case MafiaDuelFightScreen.NAME:
               return new MafiaDuelFightScreen(new MafiaBasicFight());
            case MafiaReplayFightScreen.NAME:
               return new MafiaReplayFightScreen(new MafiaBasicFight());
            case MafiaWantedFightScreen.NAME:
               return new MafiaWantedFightScreen(new MafiaBasicFight());
            case MafiaMissionFightScreen.NAME:
               return new MafiaMissionFightScreen(new MafiaBasicFight());
            case MafiaGangwarFightScreen.NAME:
               return new MafiaGangwarFightScreen(new MafiaBasicFight());
            case MafiaPoliceFightScreen.NAME:
               return new MafiaPoliceFightScreen(new MafiaBasicFight());
            case MafiaClanFightScreen.NAME:
               return new MafiaClanFightScreen(new MafiaMultiFight());
            case MafiaMailingScreen.NAME:
               return new MafiaMailingScreen(new MafiaMailing());
            case MafiaClanCreationScreen.NAME:
               return new MafiaClanCreationScreen(new MafiaClanCreation());
            case MafiaUserClanScreen.NAME:
               return new MafiaUserClanScreen(new MafiaClan());
            case MafiaOtherClanScreen.NAME:
               return new MafiaOtherClanScreen(new MafiaClan());
            case MafiaGangwarScreen.NAME:
               return new MafiaGangwarScreen(new MafiaGangwar());
            case MafiaGangwarTreeScreen.NAME:
               return new MafiaGangwarTreeScreen(new MafiaGangwarTree());
            case MafiaCustomizeAvatarScreen.NAME:
               return new MafiaCustomizeAvatarScreen(new MafiaCustomizeAvatar());
            case MafiaHomeScreen.NAME:
               return new MafiaHomeScreen(new MafiaHome());
            case MafiaSurvivalScreen.NAME:
               return new MafiaSurvivalScreen(new MafiaSurvival());
            case MafiaSurvivalFightScreen.NAME:
               return new MafiaSurvivalFightScreen(new MafiaSurvivalFight());
            case MafiaGangScreen.NAME:
               return new MafiaGangScreen(new MafiaGang());
            case MafiaTournamentScreen.NAME:
               return new MafiaTournamentScreen(new MafiaTournament());
            case MafiaTournamentFightScreen.NAME:
               return new MafiaTournamentFightScreen(new MafiaBasicFight());
            case MafiaCityBonusFightScreen.NAME:
               return new MafiaCityBonusFightScreen(new MafiaBasicFight());
            case MafiaBonusOpponentQuestScreen.NAME:
               return new MafiaBonusOpponentQuestScreen(new MafiaBonusOpponentQuest());
            case MafiaRegisterPanel.NAME:
               return new MafiaRegisterPanel(new MafiaRegistration());
            case MafiaChooseTravelPanel.NAME:
               return new MafiaChooseTravelPanel(new MafiaChooseTravel());
            case MafiaTravelProgressPanel.NAME:
               return new MafiaTravelProgressPanel(new MafiaTravel());
            case MafiaLoginPanel.NAME:
               return new MafiaLoginPanel(new MafiaLogin());
            case MafiaActionPanel.NAME:
               return new MafiaActionPanel(new ActionPanel());
            case MafiaMissionProgressPanel.NAME:
               return new MafiaMissionProgressPanel(new MafiaMissionProgress());
            case MafiaStartWorkPanel.NAME:
               return new MafiaStartWorkPanel(new MafiaStartWork());
            case MafiaWorkProgressPanel.NAME:
               return new MafiaWorkProgressPanel(new MafiaWorkProgress());
            case MafiaWorkFinishedPanel.NAME:
               return new MafiaWorkFinishedPanel(new MafiaWorkFinished());
            case MafiaBuddylistPanel.NAME:
               return new MafiaBuddylistPanel(new BuddylistPanel());
            case MafiaClanMemberPanel.NAME:
               return new MafiaClanMemberPanel(new MafiaClanMemberMenue());
            case MafiaMissionSelectionPanel.NAME:
               return new MafiaMissionSelectionPanel(new MafiaMissionSelection());
            case MafiaAvatarNameSelectionPanel.NAME:
               return new MafiaAvatarNameSelectionPanel(new NameSelection());
            case MafiaSlotmachinePanel.NAME:
               return new MafiaSlotmachinePanel(new MafiaSlotmachine());
            case MafiaHelpPanel.NAME:
               return new MafiaHelpPanel(new MafiaHelp());
            case MafiaSicilianNoMissionPanel.NAME:
               return new MafiaSicilianNoMissionPanel(new MafiaSicilianNoMissionSelection());
            case MafiaSicilianGoToGangwarPanel.NAME:
               return new MafiaSicilianGoToGangwarPanel(new MafiaSicilianGoToGangwar());
            case MafiaQuestProgressChangePanel.NAME:
               return new MafiaQuestProgressChangePanel(new MafiaQuestProgressChange());
            case MafiaQuestlogPanel.NAME:
               return new MafiaQuestlogPanel(new MafiaQuestlog());
            case MafiaBuyEnergyDialog.NAME:
               return new MafiaBuyEnergyDialog(new MafiaBuyEnergy());
            case MafiaAvatarNameSelectionDialog.NAME:
               return new MafiaAvatarNameSelectionDialog(new MafiaAvatarNameSelection());
            case MafiaWorldSelectionDialog.NAME:
               return new MafiaWorldSelectionDialog(new MafiaWorldSelection());
            case MafiaStandardOkDialog.NAME:
               return new MafiaStandardOkDialog(new MafiaStandardOk());
            case MafiaStandardYesNoDialog.NAME:
               return new MafiaStandardYesNoDialog(new MafiaStandardYesNo());
            case MafiaDeactivateFoodDialog.NAME:
               return new MafiaDeactivateFoodDialog(new MafiaStandardYesNo());
            case MafiaLostPasswordDialog.NAME:
               return new MafiaLostPasswordDialog(new LostPassword());
            case MafiaWelcomeDialog.NAME:
               return new MafiaWelcomeDialog(new MafiaWelcomeBonus());
            case MafiaLevelUpDialog.NAME:
               return new MafiaLevelUpDialog(new MafiaLevelUp());
            case MafiaClanLevelUpDialog.NAME:
               return new MafiaClanLevelUpDialog(new MafiaClanLevelUp());
            case MafiaNewAchievementDialog.NAME:
               return new MafiaNewAchievementDialog(new MafiaAchievement());
            case MafiaChangePasswordDialog.NAME:
               return new MafiaChangePasswordDialog(new ChangePassword());
            case MafiaBonusDialog.NAME:
               return new MafiaBonusDialog(new BonusDialog());
            case MafiaCustomizeCrestDialog.NAME:
               return new MafiaCustomizeCrestDialog(new MafiaCustomizeCrest());
            case MafiaReviewTutorialPanel.NAME:
               return new MafiaReviewTutorialPanel(new MafiaTutorial());
            case MafiaUnlockSlotDialog.NAME:
               return new MafiaUnlockSlotDialog(new MafiaStandardYesNo());
            case MafiaUnlockArmamentDialog.NAME:
               return new MafiaUnlockArmamentDialog(new MafiaUnlockArmament());
            case MafiaActivateBattleArmamentDialog.NAME:
               return new MafiaActivateBattleArmamentDialog(new MafiaActivateBattleArmament());
            case MafiaShowClanWarDialog.NAME:
               return new MafiaShowClanWarDialog(new MafiaStandardYesNo());
            case MafiaAddFriendDialog.NAME:
               return new MafiaAddFriendDialog(new AddFriends());
            case MafiaReconnectDialog.NAME:
               return new MafiaReconnectDialog(new MafiaReconnect());
            case MafiaUnlockGangwarDialog.NAME:
               return new MafiaUnlockGangwarDialog(new MafiaUnlockGangwar());
            case MafiaFullInventoryDialog.NAME:
               return new MafiaFullInventoryDialog(new MafiaFullInventory());
            case MafiaMailVerificationDialog.NAME:
               return new MafiaMailVerificationDialog(new MafiaMailVerification());
            case MafiaMailVerificationSendDialog.NAME:
               return new MafiaMailVerificationSendDialog(new MafiaMailVerificationSend());
            case MafiaMailGiftDialog.NAME:
               return new MafiaMailGiftDialog(new MafiaMailGift());
            case MafiaMailGiftReminderDialog.NAME:
               return new MafiaMailGiftReminderDialog(new MafiaMailGiftReminder());
            case MafiaNoCashDialog.NAME:
               return new MafiaNoCashDialog(new MafiaNoCash());
            case MafiaNoGoldDialog.NAME:
               return new MafiaNoGoldDialog(new MafiaNoGold());
            case MafiaDeactivateTresorItemDialog.NAME:
               return new MafiaDeactivateTresorItemDialog(new MafiaStandardYesNo());
            case MafiaPolicePostBailDialog.NAME:
               return new MafiaPolicePostBailDialog(new MafiaPolicePostBail());
            case MafiaCapoVitoDialog.NAME:
               return new MafiaCapoVitoDialog(new EventDialog_11());
            case MafiaCapoVitoFinishedDialog.NAME:
               return new MafiaCapoVitoFinishedDialog(new EventDialog_12());
            case MafiaSicilianMissionDialog.NAME:
               return new MafiaSicilianMissionDialog(new EventDialog_3());
            case MafiaSicilianDungeonDialog.NAME:
               return new MafiaSicilianDungeonDialog(new EventDialog_4());
            case MafiaSicilianFinishedDialog.NAME:
               return new MafiaSicilianFinishedDialog(new EventDialog_5());
            case MafiaSicilianThankYouDialog.NAME:
               return new MafiaSicilianThankYouDialog(new EventDialog_6());
            case MafiaCalendarEventDialog.NAME:
               return new MafiaCalendarEventDialog(new EventDialog_7());
            case MafiaEddyFrostEventDialog.NAME:
               return new MafiaEddyFrostEventDialog(new EventDialog_10());
            case MafiaBreakingTheLawDialog.NAME:
               return new MafiaBreakingTheLawDialog(new EventDialog_8());
            case MafiaLuckyDevilDialog.NAME:
               return new MafiaLuckyDevilDialog(new EventDialog_9());
            case MafiaNightOfHorrorDialog.NAME:
               return new MafiaNightOfHorrorDialog(new EventDialog_1());
            case MafiaNightOfHorrorFinishedDialog.NAME:
               return new MafiaNightOfHorrorFinishedDialog(new EventDialog_2());
            case MafiaBreakingTheLawIsOverDialog.NAME:
               return new MafiaBreakingTheLawIsOverDialog(new MafiaBreakingTheLawIsOver());
            case MafiaCalendarEventUnlockEnemyDialog.NAME:
               return new MafiaCalendarEventUnlockEnemyDialog(new MafiaUnlockGangwar());
            case MafiaSurvivalFightLostWonDialog.NAME:
               return new MafiaSurvivalFightLostWonDialog(new MafiaHellFightLostWon());
            case MafiaSellEquipBuyItemDialog.NAME:
               return new MafiaSellEquipBuyItemDialog(new MafiaSellEquipBuyItem());
            case MafiaTournamentRegisterDialog.NAME:
               return new MafiaTournamentRegisterDialog(new MafiaTournamentRegister());
            case MafiaTournamentRoundReportDialog.NAME:
               return new MafiaTournamentRoundReportDialog(new MafiaTournamentRoundReport());
            case MafiaTournamentWinnerDialog.NAME:
               return new MafiaTournamentWinnerDialog(new MafiaTournamentWinner());
            case MafiaPreCombatScreen.NAME:
               return new MafiaPreCombatScreen(new MafiaPreCombat());
            case MafiaClanPinboardEditDialog.NAME:
               return new MafiaClanPinboardEditDialog(new ClanPinboardEdit());
            case MafiaCombatLogDialog.NAME:
               return new MafiaCombatLogDialog(new MafiaCombatLog());
            case MafiaStartQuestDialog.NAME:
               return new MafiaStartQuestDialog(new MafiaStartQuest());
            case MafiaCompleteQuestDialog.NAME:
               return new MafiaCompleteQuestDialog(new MafiaCompleteQuest());
            case MafiaProgressQuestDialog.NAME:
               return new MafiaProgressQuestDialog(new MafiaPauseQuest());
            case MafiaInterruptQuestDialog.NAME:
               return new MafiaInterruptQuestDialog(new MafiaStandardYesNo());
            default:
               throw Error("Unknown component: " + param1);
         }
      }
   }
}
