 class TextingAppState implements ProcedureState {
   class MainScreenState implements ProcedureState {
     class Contact {
       private contactState contactState;
       private int originX;
       private int originY;
       private int boxWidth;
       private int boxHeight;
       
       Contact(contactState contactState, int originX, int originY,
         int boxWidth, int boxHeight) {
           
         this.contactState = contactState;
         this.originX = originX;
         this.originY = originY;
         this.boxWidth = boxWidth;
         this.boxHeight = boxHeight;
       }
       
       void draw() {
         fill(0, 0, 255);
         rect(this.originX, this.originY, this.boxWidth, this.boxHeight);
         fill(0, 0, 0);
         text(this.name, this.originX, this.originY, this.boxWidth, this.boxHeight);
       }
       
       Boolean inBox(int x, int y) {
         return ((x >= this.originX) && (x <= this.originX+this.boxWidth) 
             && (y >= this.originY) && (y <= this.originY+this.boxHeight))
       }
       
       contactState getContactState() {
         return this.contactState;
       }
     }
         
     private Contact[] contacts;
     private ProcessingState overState;
     
     //Constructor
     MainScreenState(ContactState[] contacts, ProcessingState overState) {
       this.overState = overState;
       entryHeight = int(phoneScreenH/contact.length);
       entryX = phoneScreenOriginX + 5;
       entryY = phoneScreenOriginY + 2;
       entryWidth = phoneScreenW - 10;
       for(int i = 0; i<contacts.length; i++) {
         Contact contact = new Contact(contacts[i], entryX, entryY, entryWidth,
           entryHeight - 4);
         this.contacts[i] = contact;
         entryY += entryHeight;
       }
     }
     
     void draw(Game g) {
       for(int i = 0; i < contacts.length; i++) {
         contacts[i].draw();
       }
     }
     
     void mouseClicked(Game g) {
       for(int i = 0; i<contacts.length; i++) {
         if(contacts[i].inBox(mouseX, mouseY)) {
           overState.setScreenState(contacts[i].getContactState());
         }
       }
     }
  }
       
   class ContactState implements ProcedureState {
     private String name;
     private String[] helpfulResponses;
     private String[] unhelpfulResponses;
     private float probHelpful;
     private int dayLosesPhone;
     private Boolean phoneTaken = false;
     private String[] rebelPloys = {"New phone, where this?", 
                                    "Send pics of st signs plz",
                                    "Wrong number, but you sound cute, where are you",
                                    "CONGRATULATIONS!!! You have sent our 1,000,000th message! Send us your location so we can bring you your PRIZE!",
                                    "FREE CZR MSG: Please reply with your location so we can match you with the appropriate cell tower"}
     contactState(String name, String[] helpfulResponses, String[] unhelpfulResponses, float probHelpful, int dayLosesPhone) {
       this.name = name;
       this.helpfulResponses = helpfulResponses;
       this.unhelpfulResponses = unhelpfulResponses;
       this.probHelpful = probHelpful;
       this.dayLosesPhone = dayLosesPhone;
     }
     
     void draw(Game g) {
      //fill background to white
      fill(255, 255, 255);
      rect(phoneScreenOriginX, phoneScreenOriginY, phoneScreenW, phoneScreenH);
      
      //draw text bubble
      fill(100, 0, 255);
      noStroke();
      triangle(phoneScreenOriginX + 5, phoneScreenOriginY + 353, phoneScreenOriginX + 10, phoneScreenOriginY + 353, 
               phoneScreenOriginX + 10, phoneScreenOriginY + 343);
      rect(phoneScreenOriginX + 10, phoneScreenOriginY + 100, 175, 253);
      
      //determine loyalist and traitor
      Tile anaTile = g.anastasiaTile();
      Tile[] neighbors = anaTile.getNeighbors();
      ArrayList<Person> allies = new ArrayList<Person>;
      ArrayList<Person> traitors = new ArrayList<Person>;
      for(int i = 0; i<neighbors.length; i++) {
        if(neighbors[i] != null) {
          if neighbors[i].allegedSafeHouseOwner.isTurned() {
            traitors.append(neighbors[i].allegedSafeHouseOwner);
          }
          else {
            allies.append(neighbors[i].allegedSafeHouseOwner);
          }
        }
      }
      //check whether phone is lost
      if(g.currentDay >= dayLosesPhone) {
        this.phoneTaken = true;
      }
      
      //choose message
      String message = "";
      if(phoneTaken) {
        int index = int(random(rebelPloys.length));
        message = rebelPloy[index];
      }
      else {
        Boolean helpful = false;
        if(random() <= probHelpful) {
          helpful = true;
        }
        if(helpful) {
          Boolean validMessage = false;
          while(!validMessage) {
            int index = int(random(this.helpfulResponses.length));
            message = this.helpfulResponses[index];
            if(((message.indexOf("#") != -1) && !allies.empty()) || ((message.indexOf("~") != -1) && !traitors.empty())) {
              validMessage = true;
            }
          }
          int curlyIndex = message.indexOf("{");
          message = message.substring(0, curlyIndex) + message.substring(curlyIndex+1);
          curlyIndex = message.indexOf("}");
          message = message.substring(0, curlyIndex) + message.substring(curlyIndex+1);
        }
        else {
          Boolean fromHelpful = false;
          if(random() <= float(helpfulResponses.length)/float(helpfulResponses.length + unhelpfulResponses.length)) {
            fromHelpful = true;
          }
          if(fromHelpful) {
            int index = int(random(this.helpfulResponses.length));
            message = this.helpfulResponses[index];
            int curlyIndex = message.indexOf("{");
            String messagePiece = message.substring(0, curlyIndex)
            curlyIndex = message.indexOf("}");
            message = messagePiece + message.substring(curlyIndex+1);
          }
          else {
            int index = int(random(this.unhelpfulResponses.length));
            message = this.unhelpfulResponses[index];
          }
        }
      }
      if(message.indexOf("#") != -1) {
        message = message.substring(0, message.indexOf("#")) + g.loyalist + message.substring(message.indexOf("#")+1);
      }
      else if(message.indexOf("~") != -1) {
        message = message.substring(0, message.indexOf("~")) + g.traitor + message.substring(message.indexOf("~")+1);
      }
      
      fill(255, 255, 255);
      text(message, phoneScreenOriginX + 10, phoneScreenOriginY + 100, 160, 253);
     
     void mouseClicked(Game g) {
       g.current = g.phoneHomeScreen;
     }
     
     String getName() {
       return this.name;
     }
   }
     
   private final float probDadHelps = .5;
   private final float probMomHelps = .05;
   private final float probOlenkaHelps = .65;
   private final float probTatyaHelps = .8;
   private final float probMashkaHelps = .4;
   private final float probAlyoshaHelps = .55;
   private final float probRasputinHelps = 0; //Rasputin is always too drunk to help
   private final String[] dadHelpful = {"Don't worry Malenkaya! Your Dad's going to kick those rebels in the ass! We'll all be home soon. {Say, if you need somewhere to stay, check with my old friend #! I'm sure they're still loyal!",
                                        "My sweet Malenkaya! {I've just received word from my friend #. They would shelter you if you pass that way. They're raising a czarist army!} Soon we'll have these rebels whipped, and I'll get out of this prison!",
                                        "Malenkaya! {Stay away from ~; they're a damn turncoat!} You keep safe, and don't worry! These rebels are no match for old Czar Nicky 2!"};
   private final String[] dadUnHelpful = {"Malenkaya! Next time these rebel scumbags bring me a meal I'm going to bash their heads in and escape! See you soon!",
                                          "Ah, Malenkaya! I've got a plan to send all these rebels straight to Siberian Groves and restore order around here!"};
   private final String[] momHelpful = {"Trust no one, Malenkaya, no one. {Especially not ~.}"}'
   private final String[] momUnHelpful = {"Pray for our souls, Malenkaya, for we are surely all doomed.",
                                          "Malenkaya, your brother won't stop bleeding. I pray constantly like Rasputin said, but he won't stop bleeding.",
                                          "Please Malenkaya, find Rasputin and bring him to save us.",
                                          "I don't think I'll live to message you again. Goodbye, my dead Malenkaya. I love you."};
   private final String[] olenkaHelpful = {"Anastasia, you would not believe these peasants that have captured us. They are NOT treating us according to our station. It's utterly barbaric. Stay ahead of them, little sister. It shouldn't be hard; they're all dolts. {If you need help, I hear # remains true to us.}",
                                           "I can't say much; these filthy guards might come back to leer at Tatya and I at any moment. Stay safe. {# is still a friend.}",
                                           "Anastasia, can you believe how many formerly decent people have joined up with this peasant rabble? It's absurd. {I mean, even ~'s joined them.}"};
   private final String[] olenkaUnHelpful = {"Keep safe, Anastasia, and don't be too afraid. These plebs don't stand a chance at governing Romanov Heights. They will soon collapse, and then we shall restore order",
                                             "Stay ahead of these rebels, Anastasia. We might join you soon. I know things about this house where they're holding us that the rebels don't"};
   private final String[] tatyaHelpful = {"Stay hidden, Anastasia, and don't worry. I have a plan to get us out of here. {If you need help, I heard the guards whispering that # remains true to the empire.}",
                                          "Don't worry, Anastasia. These Bolsheviks are horribly undisciplined. They'll never be able to hold a Homeowners Association together. Soon the people will beg for our return. {Go to # if you need a safe place until then.}",
                                          "Have hope Anastasia! The guards here are easily manipulated. Olga and I are plotting our escape, and our plan is good. {If you can find #, they are still our friend.}",
                                          "Fear not, Anastasia. You know how crafty your sisters can be. We'll be out of here soon enough. {Have you seen #? They would never turn against us."};
   private final String[] tatyaUnHelpful = {"Anastasia, we'll be out of here soon, and then we'll put these rebels in their place. Have you seen the colors they're painting their houses? It must be stopped."};
   private final String[] mashkaHelpful = {"I'm glad to hear you're safe, my dearest sister! So many of our friends have been hurt in this revolution. Though I must say I don't miss the Approved Imperial Flowers List. We can see gardens out the windows here and they are all so beautiful and filled with new flowers. {Anyway, if you need a safe place to stay # has had a crush on you for ages; they'd do anything for you.}"
                                           "Oh Nastya, I'm so glad you're alright! I've been worried about you. Stay safe out there! {I hear that # is still loyal to our family; they would shelter you if you needed it.} The Bolsheviks are treating me well, I'm sure we'll be released soon."};
   private final String[] mashkaUnHelpful = {"Nastya! I'm so glad you're not here with us, but I do miss you terribly. The family is not taking imprisonment well, though I find the Bolsheviks quite civil. Better than being captured by the Kaiser's forces, I imagine."};
   private final String[] alyoshaHelpful = {"Anastasia, these rebels are not kind to us. They won't even feed us proper food. I hope you're safe. {Yesterday I saw ~ here conferring with the rebels. I think they've betrayed us.}",
                                            "Oh Anastasia, I'm so frightened! The rebels threw me against a wall and I cut my arm, and we're all praying like Rasputin told us to but the bleeding won't stop. The pain is so terrible. If I die, know that I love you. I hope you escape. {Remember that our friend # has evaded capture and could help you.}",
                                            "Anastasia, I don't think we're going to survive. Please escape, and make sure the world remembers that Romanov Heights was once a place of beauty and order. {If you need somewhere to stay, Father # would never betray a friend of Rasputin.}"};
   private final String[] alyoshaUnHelpful = {"I am in so much pain, Anastasia. I wish I would die.",
                                              "Anastasia, I'm worried about Mother. She doesn't eat or sleep. I don't think she's stopped praying in three days. I know Rasputin says we must show our devotion to God, but does God really want her to suffer like this?"};
   private final String[] rasputinHelpful = {};
   private final String[] rasputinUnHelpful = {"And ye have meat which he dispersed among thus place.",
                                               "Art thou, being intensions of congress, capable to marriage.",
                                               "For he it is pressed into the king.",
                                               "The whole nation, is of opinion the conscious kind, it is called the love.",
                                               "The rules of good teeth, is called a 'line.'",  
                                               "But he serpent in thy cheek.",
                                               "A man which the nature hateth, will.",
                                               "But, lo, he can do his glory things that satisfy him, and saith, Behold an embracing.",
                                               "Art thou do these things be? Jesus way." ,
                                               "God is drink; thou great force, such is in the hidden biting.",
                                               "Andrew the waterpots will was though kissing takes a man marries the breasts.",
                                               "Verily, verily, I am that man lose to touchings Jesus went his disciples went down, him ye this kiss."};
                                             
   private ProcedureState screenState;
   private MainScreenState mainScreen;
   private ContactState dad;
   private ContactState mom;
   private ContactState olenka;
   private ContactState tatya;
   private ContactState mashka;
   private ContactState alyosha;
   private ContactState rasputin;
   
   TextingAppState() {
     int dayDadLosesPhone = 7 + int(randomGaussian());
     int dayMomLosesPhone = 14 + int(randomGaussian());
     int dayOlenkaLosesPhone = 11 + int(randomGaussian());
     int dayTatyaLosesPhone = 4 + int(randomGaussian());
     int dayMashkaLosesPhone = 2 + int(randomGaussian());
     int dayAlyoshaLosesPhone = 9 + int(randomGaussian());
     int dayRasputinLosesPhone = Integer.MAX_VALUE; //Rasputin was not captured and so never loses his phone
     dad = new ContactState("Dad", dadHelpful, dadUnHelpful, probDadHelps, dayDadLosesPhone);
     mom = new ContactState("Mom", momHelpful, momUnHelpful, probMomHelps, dayMomLosesPhone);
     olenka = new ContactState("Olenka", olenkaHelpful, olenkaUnHelpful, probOlenkaHelps, dayOlenkaLosesPhone);
     tatya = new ContactState("Tatya", tatyaHelpful, tatyaUnHelpful, probTatyaHelps, dayTatyaLosesPhone);
     mashka = new ContactState("Mashka", mashkaHelpful, mashkaUnHelpful, probMashkaHelps, dayMashkaLosesPhone);
     alyosha = new ContactState("Alyosha", alyoshaHelpful, alyoshaUnHelpful, probAlyoshaHelps, dayAlyoshaLosesPhone);
     rasputin = new ContactState("Rasputin", rasputinHelpful, rasputinUnHelpful, probRasputinHelps, dayRasputinLosesPhone);
     mainScreen = new MainScreenState({dad, mom, olenka, tatya, mashka, alyosha, rasputin}, this);
     this.screenState = mainScreen;
   }
   void draw(Game g) {
     image(g.phoneVertical, 0, 0);
     screenState.draw();
   }
   void mouseClicked() {
     screenState.mouseClicked();
   }
   void setScreenState(ProcedureState newScreenState) {
     this.screenState = newScreenState;
   }
     