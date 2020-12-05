package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class MafiaQuestlog extends MovieClip
   {
       
      
      public var btn_close:NewCloseButton;
      
      public var txt_quest_description:TextField;
      
      public var tasks:QuestlogTasks;
      
      public var txt_quest_title:TextField;
      
      public var txt_playername:TextField;
      
      public var reward:QuestlogReward;
      
      public var sidebar:QuestlogSidebar;
      
      public function MafiaQuestlog()
      {
         super();
      }
   }
}
