package com.goodgamestudios.mafia.model.components
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.MafiaEnvironmentGlobals;
   import com.goodgamestudios.mafia.controller.MafiaTipController;
   import com.goodgamestudios.mafia.event.model.MafiaTipEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.vo.TipVO;
   import flash.display.MovieClip;
   
   public class MafiaTipData
   {
      
      private static const COMMONLISTXMLID:String = "CommonTip_";
      
      private static const LOWLEVELLISTXMLID:String = "LowLevelTip_";
      
      private static const MEDIUMLEVELLISTXMLID:String = "MediumLevelTip_";
      
      private static const HIGHLEVELLISTXMLID:String = "HighLevelTip_";
       
      
      private var _level:int = 0;
      
      public var tipList:Vector.<TipVO>;
      
      private var commonTipList:Boolean = false;
      
      private var lowLevelTipList:Boolean = false;
      
      private var mediumLevelTipList:Boolean = false;
      
      private var highLevelTipList:Boolean = false;
      
      public var stopTip:Boolean = false;
      
      private var _isShowingTip:Boolean = false;
      
      private var nextupdatetime:Number = 0;
      
      public function MafiaTipData()
      {
         super();
         this.tipList = new Vector.<TipVO>();
      }
      
      public function set tipProperties(param1:int) : void
      {
         if(this._level != param1)
         {
            if(!this.commonTipList)
            {
               this.fillCommonTipList(param1);
               this.commonTipList = true;
            }
            if(param1 < 4 && !this.lowLevelTipList)
            {
               this.fillTipList(LOWLEVELLISTXMLID);
               this.lowLevelTipList = true;
            }
            if(param1 >= 4 && param1 < 9 && !this.mediumLevelTipList)
            {
               this.fillTipList(MEDIUMLEVELLISTXMLID);
               this.mediumLevelTipList = true;
            }
            if(param1 >= 9 && !this.highLevelTipList)
            {
               this.fillTipList(HIGHLEVELLISTXMLID);
               this.highLevelTipList = true;
            }
            this.tipList = this.shuffleTipList(this.tipList);
         }
         else if(this._level != 0 && this._level < param1)
         {
            this.deleteTipList();
            this.tipList = this.shuffleTipList(this.tipList);
         }
         this._level = param1;
      }
      
      private function deleteTipList() : void
      {
         var _loc1_:uint = 0;
         if(this.lowLevelTipList)
         {
            while(_loc1_ < this.tipList.length)
            {
               if(this.tipList[_loc1_].xmlId.indexOf(LOWLEVELLISTXMLID) != -1)
               {
                  this.tipList.splice(_loc1_,1);
               }
               _loc1_++;
            }
         }
         if(this.mediumLevelTipList)
         {
            while(_loc1_ < this.tipList.length)
            {
               if(this.tipList[_loc1_].xmlId.indexOf(MEDIUMLEVELLISTXMLID) != -1)
               {
                  this.tipList.splice(_loc1_,1);
               }
               _loc1_++;
            }
         }
         if(this.highLevelTipList)
         {
            while(_loc1_ < this.tipList.length)
            {
               if(this.tipList[_loc1_].xmlId.indexOf(HIGHLEVELLISTXMLID) != -1)
               {
                  this.tipList.splice(_loc1_,1);
               }
               _loc1_++;
            }
         }
      }
      
      public function update(param1:Number) : void
      {
         if(this.stopTip || !MafiaTipController.getInstance().isActive)
         {
            return;
         }
         if(param1 > this.nextupdatetime)
         {
            if(this._isShowingTip)
            {
               this._isShowingTip = false;
               BasicController.getInstance().dispatchEvent(new MafiaTipEvent(MafiaTipEvent.HIDE_TIP));
            }
            else
            {
               if(MafiaModel.tipData.tipList.length == 0 || MafiaDialogHandler.getInstance().blockDialogs)
               {
                  return;
               }
               this._isShowingTip = true;
               BasicController.getInstance().dispatchEvent(new MafiaTipEvent(MafiaTipEvent.SHOW_TIP,[this.findTip()]));
            }
         }
      }
      
      private function findTip() : TipVO
      {
         var _loc2_:TipVO = null;
         var _loc1_:uint = 0;
         while(_loc1_ < MafiaModel.tipData.tipList.length)
         {
            if(this.tipList[_loc1_].showState == MafiaLayoutManager.getInstance().actState || this.tipList[_loc1_].showState == 0)
            {
               _loc2_ = this.tip(_loc1_);
               return _loc2_;
            }
            _loc1_++;
         }
         return null;
      }
      
      private function fillTipList(param1:String) : void
      {
         if(0)
         {
         }
      }
      
      private function fillCommonTipList(param1:int) : void
      {
      }
      
      private function tipVO(param1:String, param2:MovieClip, param3:Function = null, param4:int = 0) : TipVO
      {
         var _loc5_:TipVO = new TipVO();
         _loc5_.xmlId = param1;
         _loc5_.mc = param2;
         _loc5_.functionClick = param3;
         _loc5_.showState = param4;
         _loc5_.shown = 0;
         return _loc5_;
      }
      
      public function tip(param1:int) : TipVO
      {
         var _loc2_:TipVO = this.tipList[param1] as TipVO;
         this.tipList[param1].shown++;
         if(this.tipList[param1].shown == 2)
         {
            this.tipList.splice(param1,1);
         }
         this.tipList = this.shuffleTipList(this.tipList);
         return _loc2_;
      }
      
      private function shuffleTipList(param1:Vector.<TipVO>) : Vector.<TipVO>
      {
         var _loc2_:int = param1.length;
         var _loc3_:Vector.<TipVO> = new Vector.<TipVO>(_loc2_);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_[_loc4_] = param1.splice(int(Math.random() * (_loc2_ - _loc4_)),1)[0];
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function get env() : IEnvironmentGlobals
      {
         return new MafiaEnvironmentGlobals();
      }
   }
}
