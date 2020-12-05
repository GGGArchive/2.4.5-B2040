package com.goodgamestudios.mafia.model
{
   public class MafiaTutorialData
   {
      
      protected static var tutorialData:MafiaTutorialData;
       
      
      public var tutorialShown:Boolean;
      
      public function MafiaTutorialData(param1:SingletonEnforcer#60)
      {
         super();
         this.tutorialShown = true;
      }
      
      public static function getInstance() : MafiaTutorialData
      {
         if(tutorialData == null)
         {
            tutorialData = new MafiaTutorialData(new SingletonEnforcer#60());
         }
         return tutorialData;
      }
   }
}

class SingletonEnforcer#60
{
    
   
   function SingletonEnforcer#60()
   {
      super();
   }
}
