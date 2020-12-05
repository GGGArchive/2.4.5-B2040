package com.goodgamestudios.mafia.controller.commands.police
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.policebadgeconversion.PBSpecialeventPoliceBadgeConversionRequest;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.policebadgeconversion.PBSpecialeventPoliceBadgeConversionResponse;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.dialogs.MafiaBreakingTheLawIsOverDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaBreakingTheLawIsOverProperties;
   import com.netease.protobuf.Message;
   
   public class PoliceBadgeConversionCommand extends BasicProtobufCommand
   {
       
      
      public function PoliceBadgeConversionCommand()
      {
         super();
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBSpecialeventPoliceBadgeConversionResponse = param1 as PBSpecialeventPoliceBadgeConversionResponse;
         var _loc3_:String = MafiaModel.languageData.getTextById("event_breakingthelaw_copy_12");
         var _loc4_:String = MafiaModel.languageData.getTextById("event_breakingthelaw_copy_13");
         var _loc5_:String = MafiaModel.languageData.getTextById("generic_btn_okay");
         var _loc6_:MafiaBreakingTheLawIsOverProperties = new MafiaBreakingTheLawIsOverProperties(_loc3_,_loc4_,null,_loc5_,_loc2_.rewardedXP,_loc2_.rewardedMoney);
         MafiaLayoutManager.getInstance().showDialog(MafiaBreakingTheLawIsOverDialog.NAME,_loc6_);
         return true;
      }
      
      override public function getRequestClass() : Class
      {
         return PBSpecialeventPoliceBadgeConversionRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBSpecialeventPoliceBadgeConversionResponse;
      }
   }
}
