package com.goodgamestudios.mafia.model.components.user
{
   import com.goodgamestudios.basic.model.components.BasicDialogHandler;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.controller.protobuf.misc.loginwelcome.PBMiscLoginWelcomeResponse;
   import com.goodgamestudios.mafia.controller.protobuf.misc.loginwelcome.response.PBMiscLoginWelcomeReward;
   import com.goodgamestudios.mafia.controller.protobuf.misc.loginwelcome.response.reward.PBMiscLoginWelcomeType;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.view.dialogs.MafiaWelcomeDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaWelcomeDialogProperties;
   import com.goodgamestudios.mafia.vo.WelcomeVO;
   
   public class MafiaWelcomeData
   {
       
      
      public var days:Vector.<WelcomeVO>;
      
      private const GETITONTHISDAY:int = -1;
      
      public function MafiaWelcomeData()
      {
         super();
         this.days = new Vector.<WelcomeVO>();
      }
      
      public function parseWelcomeDataPB(param1:PBMiscLoginWelcomeResponse) : void
      {
         var _loc4_:PBMiscLoginWelcomeReward = null;
         var _loc5_:WelcomeVO = null;
         var _loc2_:Array = param1.reward;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            _loc5_ = new WelcomeVO();
            _loc5_.day = _loc4_.day;
            _loc5_.type = _loc4_.type;
            switch(_loc4_.type)
            {
               case PBMiscLoginWelcomeType.CASH:
                  if(_loc4_.hasValue)
                  {
                     _loc5_.cash = _loc4_.value;
                  }
                  else
                  {
                     _loc5_.cash = this.GETITONTHISDAY;
                  }
                  break;
               case PBMiscLoginWelcomeType.GOLD:
                  if(_loc4_.hasValue)
                  {
                     _loc5_.gold = _loc4_.value;
                  }
                  else
                  {
                     _loc5_.gold = this.GETITONTHISDAY;
                  }
                  break;
               case PBMiscLoginWelcomeType.XP:
                  if(_loc4_.hasValue)
                  {
                     _loc5_.xp = _loc4_.value;
                  }
                  else
                  {
                     _loc5_.xp = this.GETITONTHISDAY;
                  }
                  break;
               case PBMiscLoginWelcomeType.ITEM:
                  if(_loc4_.hasItem)
                  {
                     _loc5_.item = MafiaItemData.parseItem(_loc4_.item,ItemLocation.Inventory,0);
                  }
                  else
                  {
                     _loc5_.item = null;
                  }
            }
            this.days.push(_loc5_);
            _loc3_++;
         }
         if(this.days.length > 0)
         {
            MafiaDialogHandler.getInstance().registerDialogs(MafiaWelcomeDialog.NAME,new MafiaWelcomeDialogProperties(this.days,MafiaModel.languageData.getTextById("MafiaDailyBonusDialog_title"),MafiaModel.languageData.getTextById("generic_btn_okay")),true,BasicDialogHandler.PRIORITY_HIGH);
         }
      }
   }
}
