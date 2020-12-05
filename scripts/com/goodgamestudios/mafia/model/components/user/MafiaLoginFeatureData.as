package com.goodgamestudios.mafia.model.components.user
{
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.vo.FeatureVO;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   
   public class MafiaLoginFeatureData
   {
       
      
      private const CURRENT_COMING_SOON_ID:int = 12;
      
      public var comingSoonId:int = 12;
      
      public var featureList:Vector.<FeatureVO>;
      
      private const FEATURELISTPARAMS:Array = [2,2,1,3,1,3,1,3,1,1,1,2,1,2,1,1,2,2,1,1,2,1,1,2,1,2,2,1];
      
      public var featureassets:FeatureAssetHolder;
      
      public function MafiaLoginFeatureData()
      {
         super();
      }
      
      public function parseFeatureData(param1:Array) : void
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         var _loc7_:FeatureVO = null;
         var _loc8_:String = null;
         param1.shift();
         this.featureList = new Vector.<FeatureVO>();
         var _loc2_:Array = param1.shift().split("#");
         _loc2_.pop();
         while(_loc2_.length > 0 && _loc2_[0] != "")
         {
            _loc3_ = String(_loc2_.shift()).split("+");
            _loc4_ = _loc3_.shift();
            _loc5_ = _loc3_.shift();
            _loc6_ = 1;
            while(_loc6_ < this.FEATURELISTPARAMS[_loc4_ - 1] + 1)
            {
               _loc7_ = new FeatureVO();
               _loc7_.id = _loc4_;
               _loc8_ = TimeStringHelper.getDateToString(_loc5_ * Constants_Basic.SEC2MILLISEC * Constants_Basic.SEC2MILLISEC,TimeStringHelper.DATE_DAY_FORMAT,MafiaModel.languageData.getTextById);
               _loc7_.featureTime = _loc8_;
               _loc7_.subId = _loc6_;
               this.featureList.push(_loc7_);
               _loc6_++;
            }
         }
      }
   }
}
