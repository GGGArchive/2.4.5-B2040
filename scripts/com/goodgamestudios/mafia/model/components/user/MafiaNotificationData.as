package com.goodgamestudios.mafia.model.components.user
{
   import com.goodgamestudios.basic.model.components.BasicDialogHandler;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.model.components.MafiaSocialData;
   import com.goodgamestudios.mafia.view.dialogs.MafiaLevelUpDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaLevelUpDialogProperties;
   import com.goodgamestudios.mafia.vo.NotificationVO;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   
   public class MafiaNotificationData
   {
       
      
      private const NOTIFICATION_TYPE_LEVELUP:int = 0;
      
      private const NOTIFICATION_TYPE_ADMIN:int = 1;
      
      private const NOTIFICATION_TYPE_GENERIC:int = 2;
      
      public function MafiaNotificationData()
      {
         super();
      }
      
      public function parseNotification(param1:Array) : void
      {
         var _loc3_:NotificationVO = null;
         var _loc5_:Array = null;
         var _loc6_:* = null;
         param1.shift();
         var _loc2_:Array = String(param1).split("+");
         _loc3_ = new NotificationVO();
         _loc3_.type = _loc2_.shift();
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_.value.push(_loc2_[_loc4_]);
            _loc4_++;
         }
         switch(_loc3_.type)
         {
            case this.NOTIFICATION_TYPE_LEVELUP:
               _loc5_ = [_loc3_.value[0]];
               MafiaDialogHandler.getInstance().registerDialogs(MafiaLevelUpDialog.NAME,new MafiaLevelUpDialogProperties(_loc5_[0],MafiaModel.languageData.getTextById("MafiaLevelUpDialog_title"),MafiaModel.languageData.getTextById("MafiaLevelUpDialog_copy_1",_loc5_),MafiaModel.languageData.getTextById("generic_btn_share"),MafiaModel.languageData.getTextById("generic_btn_okay"),this.feedLevelUp),true,BasicDialogHandler.PRIORITY_MIDDLE);
               break;
            case this.NOTIFICATION_TYPE_ADMIN:
               MafiaDialogHandler.getInstance().registerDialogs(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(String(_loc3_.value[0]),String(_loc3_.value[1])),true,BasicDialogHandler.PRIORITY_LOW);
               break;
            case this.NOTIFICATION_TYPE_GENERIC:
               _loc6_ = String(_loc3_.value[0]) != ""?MafiaModel.languageData.getTextById("servershutdownpremonition_registered_copy",[TimeStringHelper.getTimeToString(_loc3_.value[0],TimeStringHelper.TWO_TIME_FORMAT,MafiaModel.languageData.getTextById)]):MafiaModel.languageData.getTextById("servershutdown_copy");
               _loc6_ = _loc6_ + " ";
               _loc6_ = _loc6_ + (_loc3_.value[1] && _loc3_.value[1] != ""?MafiaModel.languageData.getTextById("servershutdownpremonition_backin_copy",[TimeStringHelper.getTimeToString(_loc3_.value[1],TimeStringHelper.TWO_TIME_FORMAT,MafiaModel.languageData.getTextById)]):"");
               MafiaDialogHandler.getInstance().registerDialogs(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_watchout"),_loc6_),true,BasicDialogHandler.PRIORITY_LOW);
         }
      }
      
      private function feedLevelUp(param1:Object = null) : void
      {
         MafiaModel.socialData.postFeed(MafiaSocialData.EXTERNAL_SHARE_LEVELUP,[MafiaModel.userData.profileData.level]);
      }
   }
}
