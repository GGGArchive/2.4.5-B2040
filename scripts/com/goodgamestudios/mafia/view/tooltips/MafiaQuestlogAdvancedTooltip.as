package com.goodgamestudios.mafia.view.tooltips
{
   import com.goodgamestudios.mafia.constants.enums.QuestType;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaQuestlogAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.vo.quest.QuestTaskVO;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class MafiaQuestlogAdvancedTooltip extends MafiaAdvancedTooltip
   {
      
      public static const NAME:String = "MafiaQuestlogAdvancedTooltip";
       
      
      public function MafiaQuestlogAdvancedTooltip(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         var _loc3_:QuestTaskVO = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TextField = null;
         this.advancedTooltip.gotoAndStop(this.advancedTooltipProperties.questVO.type == QuestType.GuidingQuest?1:2);
         var _loc1_:Vector.<QuestTaskVO> = this.advancedTooltipProperties.questVO.tasks;
         this.advancedTooltip.tooltip.gotoAndStop(_loc1_.length);
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_];
            _loc4_ = this.advancedTooltip.tooltip["icon_" + _loc2_];
            _loc5_ = this.advancedTooltip.tooltip["txt_value_" + _loc2_] as TextField;
            _loc4_.gotoAndStop(_loc3_.iconId);
            _loc5_.text = _loc3_.currentValue + "/" + _loc3_.requiredValue;
            _loc5_.textColor = !!_loc3_.complete?uint(5607697):uint(0);
            _loc2_++;
         }
         switch(this.advancedTooltipProperties.questVO.type)
         {
            case QuestType.GuidingQuest:
               this.advancedTooltip.gotoAndStop(1);
               TextFieldHelper.changeTextFromatSizeByTextWidth(12,this.advancedTooltip.tooltip.txt_title,MafiaModel.languageData.getTextById("MafiaQuest_type_1"));
               break;
            case QuestType.CityQuest:
               this.advancedTooltip.gotoAndStop(2);
               TextFieldHelper.changeTextFromatSizeByTextWidth(12,this.advancedTooltip.tooltip.txt_title,MafiaModel.languageData.getTextById("MafiaQuest_type_2"));
               TextFieldHelper.changeTextFromatSizeByTextWidth(12,this.advancedTooltip.tooltip.txt_subtitle,MafiaModel.languageData.getCityName(this.advancedTooltipProperties.questVO.city) + " #" + (this.advancedTooltipProperties.questVO.districtNumber + 1));
               break;
            case QuestType.CityUnlockQuest:
               this.advancedTooltip.gotoAndStop(2);
               TextFieldHelper.changeTextFromatSizeByTextWidth(12,this.advancedTooltip.tooltip.txt_title,MafiaModel.languageData.getTextById("MafiaQuest_type_3"));
               TextFieldHelper.changeTextFromatSizeByTextWidth(12,this.advancedTooltip.tooltip.txt_subtitle,MafiaModel.languageData.getCityName(this.advancedTooltipProperties.questVO.reward.unlockCity));
         }
         updateAllTextFields();
      }
      
      protected function get advancedTooltip() : MafiaQuestlogTooltip
      {
         return disp as MafiaQuestlogTooltip;
      }
      
      protected function get advancedTooltipProperties() : MafiaQuestlogAdvancedTooltipProperties
      {
         return properties as MafiaQuestlogAdvancedTooltipProperties;
      }
   }
}
