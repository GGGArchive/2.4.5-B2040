package com.goodgamestudios.mafia.model.components.user.gang
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.event.model.MafiaGangEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.vo.GangVO;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.display.Sprite;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   
   public class MafiaGangData
   {
      
      public static const MAXGANGMEMBERS:int = 5;
      
      public static const BONUS_AMOUNT_STAR_1:int = 10;
      
      public static const BONUS_AMOUNT_STAR_2:int = 2;
      
      public static const BONUS_AMOUNT_STAR_3:int = 2;
      
      public static const BONUS_AMOUNT_STAR_4:int = 3;
      
      public static const BONUS_AMOUNT_STAR_5:int = 5;
       
      
      public var playerGang:Vector.<GangVO>;
      
      public var bonusCount:int;
      
      private const CRIT_BONUS_STAR:int = 5;
      
      public var shopGang:Vector.<GangVO>;
      
      public function MafiaGangData()
      {
         super();
         this.playerGang = new Vector.<GangVO>();
      }
      
      public function parsePlayerGang(param1:Array) : void
      {
         param1.shift();
         param1.shift();
         this.playerGang = this.parseGang(param1.shift());
         this.bonusCount = param1.shift();
      }
      
      public function checkPlayerGangMemberTime(param1:Number) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:Array = null;
         if(this.playerGang && this.playerGang.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < this.playerGang.length)
            {
               if(this.playerGang[_loc2_] != null)
               {
                  if(param1 > this.playerGang[_loc2_].endTime)
                  {
                     this.playerGang[_loc2_] = null;
                     MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_SHOW_GANG,[MafiaModel.userData.playerID]);
                  }
                  else
                  {
                     this.playerGang[_loc2_].remainingTime = TimeStringHelper.getTimeToString((this.playerGang[_loc2_].endTime - param1) * Constants_Basic.MILLISEC2SEC,TimeStringHelper.TWO_TIME_FORMAT,MafiaModel.languageData.getTextById);
                     _loc3_ = new Array();
                     _loc3_[0] = this.playerGang[_loc2_];
                     _loc3_[1] = (this.playerGang[_loc2_].remainingTimeInSeconds - param1 * Constants_Basic.MILLISEC2SEC) / (this.playerGang[_loc2_].duration * 24 * 60 * 60);
                     BasicController.getInstance().dispatchEvent(new MafiaGangEvent(MafiaGangEvent.CHANGE_OWN_USER_GANG_TIME,_loc3_));
                  }
               }
               _loc2_++;
            }
         }
      }
      
      public function parseGangShop(param1:Array) : void
      {
         param1.shift();
         this.shopGang = this.parseGang(param1.shift());
      }
      
      private function parseGang(param1:String) : Vector.<GangVO>
      {
         var _loc5_:Array = null;
         var _loc6_:GangVO = null;
         var _loc2_:Array = param1.split("#");
         _loc2_.pop();
         var _loc3_:Vector.<GangVO> = new Vector.<GangVO>();
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc5_ = String(_loc2_[_loc4_]).split("+");
            if(_loc5_[0] > 0)
            {
               _loc6_ = new GangVO();
               _loc6_.index = _loc4_;
               _loc6_.id = _loc5_.shift();
               _loc6_.picID = _loc5_.shift();
               _loc6_.costC1 = _loc5_.shift();
               _loc6_.costC2 = _loc5_.shift();
               _loc6_.effectType = _loc5_.shift();
               _loc6_.effectType++;
               _loc6_.effectValue = _loc5_.shift();
               _loc6_.starCount = _loc5_.shift();
               _loc6_.duration = _loc5_.shift();
               _loc6_.remainingTimeInSeconds = _loc5_.shift();
               _loc6_.endTime = getTimer() + _loc6_.remainingTimeInSeconds * Constants_Basic.SEC2MILLISEC;
               _loc6_.remainingTime = TimeStringHelper.getTimeToString(_loc6_.endTime,TimeStringHelper.ONE_TIME_FORMAT,MafiaModel.languageData.getTextById);
               _loc3_.push(_loc6_);
            }
            else
            {
               _loc3_.push(null);
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function generateGangMemberPic(param1:int) : Sprite
      {
         var _loc2_:Sprite = new Sprite();
         var _loc3_:Class = getDefinitionByName("GA" + param1) as Class;
         _loc2_ = new _loc3_();
         _loc2_.scaleX = _loc2_.scaleY = 0.3;
         return _loc2_;
      }
   }
}
