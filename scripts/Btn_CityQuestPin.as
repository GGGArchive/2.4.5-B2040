package
{
   import flash.display.MovieClip;
   
   public dynamic class Btn_CityQuestPin extends MovieClip
   {
       
      
      public var unlock:Btn_unlock_bonus_opponent_quest;
      
      public var noreward:Btn_win_no_reward_city_quest;
      
      public var available:Btn_available_city_quest;
      
      public var activ:Btn_activ_city_quest;
      
      public var reward:Btn_win_reward_quest;
      
      public function Btn_CityQuestPin()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         stop();
      }
   }
}
