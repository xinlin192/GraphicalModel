net Sub0
{
 HEADER = 
  {
   ID = Sub0;
   NAME = "Tank problem diagnosis by Gerardina Hernandez";
   COMMENT = "A simple network for diagnosing possible explosion in a \ 
   tank, developed by Gerardina Hernandez as a class homework at the \ 
   University of Pittsburgh.";
  };
 CREATION = 
  {
   MODIFIED = "13:45:23 Thursday, September 26, 2002";
  };
 NUMSAMPLES = 1000;
 SCREEN = 
  {
   POSITION = 
    {
     CENTER_X = 0;
     CENTER_Y = 0;
     WIDTH = 76;
     HEIGHT = 36;
    };
   COLOR = 16250597;
   SELCOLOR = 12303291;
   FONT = 1;
   FONTCOLOR = 0;
   BORDERTHICKNESS = 3;
   BORDERCOLOR = 12255232;
  };
 WINDOWPOSITION = 
  {
   CENTER_X = 68;
   CENTER_Y = 68;
   WIDTH = 594;
   HEIGHT = 349;
  };
 BKCOLOR = 16777215;
 SCREENCOMMENT =  { (99, 228, 174, 122),"A simple network for \ 
 diagnosing possible explosion in a tank, developed by Gerardina \ 
 Hernandez as a class homework at the University of Pittsburgh."};
 USER_PROPERTIES = 
  {
  };
 DOCUMENTATION = 
  {
  };
 SHOWAS = 3;

 node Oxigen
  {
   TYPE = CPT;
   HEADER = 
    {
     ID = Oxigen;
     NAME = "Oxigen";
     COMMENT = "";
    };
   SCREEN = 
    {
     POSITION = 
      {
       CENTER_X = 43;
       CENTER_Y = 26;
       WIDTH = 70;
       HEIGHT = 30;
      };
     COLOR = 16250597;
     SELCOLOR = 12303291;
     FONT = 1;
     FONTCOLOR = 0;
     BORDERTHICKNESS = 1;
     BORDERCOLOR = 12255232;
    };
   USER_PROPERTIES = 
    {
    };
   DOCUMENTATION = 
    {
    };
   PARENTS = ();
   DEFINITION = 
    {
     NAMESTATES = (present, absent);
     PROBABILITIES = (0.50000000, 0.50000000);
    };
   EXTRA_DEFINITION = 
    {
     DIAGNOSIS_TYPE = OBSERVATION;
     RANKED = TRUE;
     MANDATORY = FALSE;
     SETASDEFAULT = TRUE;
     SHOWAS = 4;
     FAULT_STATES = (0, 0);
     FAULT_NAMES = ("", "");
     FAULT_LABELS = ("F2", "F3");
     DEFAULT_STATE = 0;
     DOCUMENTATION = 
      {
      };
     DOCUMENTATION = 
      {
      };
     STATECOMMENTS = ("", "");
     STATEREPAIRINFO = ("", "");
     QUESTION = "";
    };
  };

 node Hydrogen
  {
   TYPE = CPT;
   HEADER = 
    {
     ID = Hydrogen;
     NAME = "Hydrogen";
     COMMENT = "";
    };
   SCREEN = 
    {
     POSITION = 
      {
       CENTER_X = 132;
       CENTER_Y = 27;
       WIDTH = 70;
       HEIGHT = 30;
      };
     COLOR = 16250597;
     SELCOLOR = 12303291;
     FONT = 1;
     FONTCOLOR = 0;
     BORDERTHICKNESS = 1;
     BORDERCOLOR = 12255232;
    };
   USER_PROPERTIES = 
    {
    };
   DOCUMENTATION = 
    {
    };
   PARENTS = ();
   DEFINITION = 
    {
     NAMESTATES = (present, absent);
     PROBABILITIES = (0.50000000, 0.50000000);
    };
   EXTRA_DEFINITION = 
    {
     DIAGNOSIS_TYPE = OBSERVATION;
     RANKED = TRUE;
     MANDATORY = FALSE;
     SETASDEFAULT = TRUE;
     SHOWAS = 4;
     FAULT_STATES = (0, 0);
     FAULT_NAMES = ("", "");
     FAULT_LABELS = ("F4", "F5");
     DEFAULT_STATE = 0;
     DOCUMENTATION = 
      {
      };
     DOCUMENTATION = 
      {
      };
     STATECOMMENTS = ("", "");
     STATEREPAIRINFO = ("", "");
     QUESTION = "";
    };
  };

 node ReacO
  {
   TYPE = CPT;
   HEADER = 
    {
     ID = ReacO;
     NAME = "ReacO";
     COMMENT = "";
    };
   SCREEN = 
    {
     POSITION = 
      {
       CENTER_X = 185;
       CENTER_Y = 123;
       WIDTH = 70;
       HEIGHT = 30;
      };
     COLOR = 16250597;
     SELCOLOR = 12303291;
     FONT = 1;
     FONTCOLOR = 0;
     BORDERTHICKNESS = 1;
     BORDERCOLOR = 12255232;
    };
   USER_PROPERTIES = 
    {
    };
   DOCUMENTATION = 
    {
    };
   PARENTS = (Oxigen);
   DEFINITION = 
    {
     NAMESTATES = (yes, no);
     PROBABILITIES = (0.10000000, 0.90000000, 0.00000000, 1.00000000);
    };
   EXTRA_DEFINITION = 
    {
     DIAGNOSIS_TYPE = AUXILIARY;
     RANKED = FALSE;
     MANDATORY = FALSE;
     SETASDEFAULT = FALSE;
     SHOWAS = 4;
     FAULT_STATES = (0, 0);
     FAULT_NAMES = ("", "");
     FAULT_LABELS = ("F6", "F7");
     DEFAULT_STATE = 0;
     DOCUMENTATION = 
      {
      };
     DOCUMENTATION = 
      {
      };
     STATECOMMENTS = ("", "");
     STATEREPAIRINFO = ("", "");
     QUESTION = "";
    };
  };

 node ReacH
  {
   TYPE = CPT;
   HEADER = 
    {
     ID = ReacH;
     NAME = "ReacH";
     COMMENT = "";
    };
   SCREEN = 
    {
     POSITION = 
      {
       CENTER_X = 310;
       CENTER_Y = 74;
       WIDTH = 70;
       HEIGHT = 30;
      };
     COLOR = 16250597;
     SELCOLOR = 12303291;
     FONT = 1;
     FONTCOLOR = 0;
     BORDERTHICKNESS = 1;
     BORDERCOLOR = 12255232;
    };
   USER_PROPERTIES = 
    {
    };
   DOCUMENTATION = 
    {
    };
   PARENTS = (Hydrogen);
   DEFINITION = 
    {
     NAMESTATES = (yes, no);
     PROBABILITIES = (0.10000000, 0.90000000, 0.00000000, 1.00000000);
    };
   EXTRA_DEFINITION = 
    {
     DIAGNOSIS_TYPE = AUXILIARY;
     RANKED = FALSE;
     MANDATORY = FALSE;
     SETASDEFAULT = FALSE;
     SHOWAS = 4;
     FAULT_STATES = (0, 0);
     FAULT_NAMES = ("", "");
     FAULT_LABELS = ("F8", "F9");
     DEFAULT_STATE = 0;
     DOCUMENTATION = 
      {
      };
     DOCUMENTATION = 
      {
      };
     STATECOMMENTS = ("", "");
     STATEREPAIRINFO = ("", "");
     QUESTION = "";
    };
  };

 node Sensor1
  {
   TYPE = CPT;
   HEADER = 
    {
     ID = Sensor1;
     NAME = "Sensor1";
     COMMENT = "";
    };
   SCREEN = 
    {
     POSITION = 
      {
       CENTER_X = 115;
       CENTER_Y = 144;
       WIDTH = 70;
       HEIGHT = 30;
      };
     COLOR = 16250597;
     SELCOLOR = 12303291;
     FONT = 1;
     FONTCOLOR = 0;
     BORDERTHICKNESS = 1;
     BORDERCOLOR = 12255232;
    };
   USER_PROPERTIES = 
    {
    };
   DOCUMENTATION = 
    {
    };
   PARENTS = (Oxigen, Hydrogen);
   DEFINITION = 
    {
     NAMESTATES = (on, off);
     PROBABILITIES = (0.90000000, 0.10000000, 0.10000000, 0.90000000, 
     0.10000000, 0.90000000, 0.90000000, 0.10000000);
    };
   EXTRA_DEFINITION = 
    {
     DIAGNOSIS_TYPE = AUXILIARY;
     RANKED = FALSE;
     MANDATORY = FALSE;
     SETASDEFAULT = FALSE;
     SHOWAS = 4;
     FAULT_STATES = (0, 0);
     FAULT_NAMES = ("", "");
     FAULT_LABELS = ("F10", "F11");
     DEFAULT_STATE = 0;
     DOCUMENTATION = 
      {
      };
     DOCUMENTATION = 
      {
      };
     STATECOMMENTS = ("", "");
     STATEREPAIRINFO = ("", "");
     QUESTION = "";
    };
  };

 node Explosion
  {
   TYPE = CPT;
   HEADER = 
    {
     ID = Explosion;
     NAME = "Explosion";
     COMMENT = "";
    };
   SCREEN = 
    {
     POSITION = 
      {
       CENTER_X = 280;
       CENTER_Y = 135;
       WIDTH = 70;
       HEIGHT = 30;
      };
     COLOR = 16250597;
     SELCOLOR = 12303291;
     FONT = 1;
     FONTCOLOR = 0;
     BORDERTHICKNESS = 1;
     BORDERCOLOR = 12255232;
    };
   USER_PROPERTIES = 
    {
    };
   DOCUMENTATION = 
    {
    };
   PARENTS = (Oxigen, Hydrogen);
   DEFINITION = 
    {
     NAMESTATES = (yes, no);
     PROBABILITIES = (0.90000000, 0.10000000, 0.00000000, 1.00000000, 
     0.00000000, 1.00000000, 0.00000000, 1.00000000);
    };
   EXTRA_DEFINITION = 
    {
     DIAGNOSIS_TYPE = AUXILIARY;
     RANKED = FALSE;
     MANDATORY = FALSE;
     SETASDEFAULT = FALSE;
     SHOWAS = 4;
     FAULT_STATES = (0, 0);
     FAULT_NAMES = ("", "");
     FAULT_LABELS = ("F12", "F13");
     DEFAULT_STATE = 0;
     DOCUMENTATION = 
      {
      };
     DOCUMENTATION = 
      {
      };
     STATECOMMENTS = ("", "");
     STATEREPAIRINFO = ("", "");
     QUESTION = "";
    };
  };

 node Sensor2
  {
   TYPE = CPT;
   HEADER = 
    {
     ID = Sensor2;
     NAME = "Sensor2";
     COMMENT = "";
    };
   SCREEN = 
    {
     POSITION = 
      {
       CENTER_X = 44;
       CENTER_Y = 111;
       WIDTH = 70;
       HEIGHT = 30;
      };
     COLOR = 16250597;
     SELCOLOR = 12303291;
     FONT = 1;
     FONTCOLOR = 0;
     BORDERTHICKNESS = 1;
     BORDERCOLOR = 12255232;
    };
   USER_PROPERTIES = 
    {
    };
   DOCUMENTATION = 
    {
    };
   PARENTS = (Oxigen);
   DEFINITION = 
    {
     NAMESTATES = (on, off);
     PROBABILITIES = (0.90000000, 0.10000000, 0.10000000, 0.90000000);
    };
   EXTRA_DEFINITION = 
    {
     DIAGNOSIS_TYPE = AUXILIARY;
     RANKED = FALSE;
     MANDATORY = FALSE;
     SETASDEFAULT = FALSE;
     SHOWAS = 4;
     FAULT_STATES = (0, 0);
     FAULT_NAMES = ("", "");
     FAULT_LABELS = ("F14", "F15");
     DEFAULT_STATE = 0;
     DOCUMENTATION = 
      {
      };
     DOCUMENTATION = 
      {
      };
     STATECOMMENTS = ("", "");
     STATEREPAIRINFO = ("", "");
     QUESTION = "";
    };
  };

 node C_Oxigen
  {
   TYPE = CPT;
   HEADER = 
    {
     ID = C_Oxigen;
     NAME = "C_Oxigen";
     COMMENT = "";
    };
   SCREEN = 
    {
     POSITION = 
      {
       CENTER_X = 208;
       CENTER_Y = 196;
       WIDTH = 70;
       HEIGHT = 30;
      };
     COLOR = 16250597;
     SELCOLOR = 12303291;
     FONT = 1;
     FONTCOLOR = 0;
     BORDERTHICKNESS = 1;
     BORDERCOLOR = 12255232;
    };
   USER_PROPERTIES = 
    {
    };
   DOCUMENTATION = 
    {
    };
   PARENTS = (Oxigen, Explosion, ReacO);
   DEFINITION = 
    {
     NAMESTATES = (present, absent);
     PROBABILITIES = (0.00000000, 1.00000000, 0.00000000, 1.00000000, 
     0.00000000, 1.00000000, 1.00000000, 0.00000000, 0.00000000, 
     1.00000000, 0.00000000, 1.00000000, 0.00000000, 1.00000000, 
     0.00000000, 1.00000000);
    };
   EXTRA_DEFINITION = 
    {
     DIAGNOSIS_TYPE = AUXILIARY;
     RANKED = FALSE;
     MANDATORY = FALSE;
     SETASDEFAULT = FALSE;
     SHOWAS = 4;
     FAULT_STATES = (0, 0);
     FAULT_NAMES = ("", "");
     FAULT_LABELS = ("F16", "F17");
     DEFAULT_STATE = 0;
     DOCUMENTATION = 
      {
      };
     DOCUMENTATION = 
      {
      };
     STATECOMMENTS = ("", "");
     STATEREPAIRINFO = ("", "");
     QUESTION = "";
    };
  };

 node C_Hydrogen
  {
   TYPE = CPT;
   HEADER = 
    {
     ID = C_Hydrogen;
     NAME = "C_Hydrogen";
     COMMENT = "";
    };
   SCREEN = 
    {
     POSITION = 
      {
       CENTER_X = 391;
       CENTER_Y = 154;
       WIDTH = 85;
       HEIGHT = 30;
      };
     COLOR = 16250597;
     SELCOLOR = 12303291;
     FONT = 1;
     FONTCOLOR = 0;
     BORDERTHICKNESS = 1;
     BORDERCOLOR = 12255232;
    };
   USER_PROPERTIES = 
    {
    };
   DOCUMENTATION = 
    {
    };
   PARENTS = (Hydrogen, ReacH, Explosion);
   DEFINITION = 
    {
     NAMESTATES = (present, absent);
     PROBABILITIES = (0.00000000, 1.00000000, 0.00000000, 1.00000000, 
     0.00000000, 1.00000000, 1.00000000, 0.00000000, 0.00000000, 
     1.00000000, 0.00000000, 1.00000000, 0.00000000, 1.00000000, 
     0.00000000, 1.00000000);
    };
   EXTRA_DEFINITION = 
    {
     DIAGNOSIS_TYPE = AUXILIARY;
     RANKED = FALSE;
     MANDATORY = FALSE;
     SETASDEFAULT = FALSE;
     SHOWAS = 4;
     FAULT_STATES = (0, 0);
     FAULT_NAMES = ("", "");
     FAULT_LABELS = ("F18", "F19");
     DEFAULT_STATE = 0;
     DOCUMENTATION = 
      {
      };
     DOCUMENTATION = 
      {
      };
     STATECOMMENTS = ("", "");
     STATEREPAIRINFO = ("", "");
     QUESTION = "";
    };
  };

 node C_ReacO
  {
   TYPE = NOISY_OR;
   HEADER = 
    {
     ID = C_ReacO;
     NAME = "C_ReacO";
     COMMENT = "";
    };
   SCREEN = 
    {
     POSITION = 
      {
       CENTER_X = 228;
       CENTER_Y = 265;
       WIDTH = 70;
       HEIGHT = 30;
      };
     COLOR = 16250597;
     SELCOLOR = 12303291;
     FONT = 1;
     FONTCOLOR = 0;
     BORDERTHICKNESS = 1;
     BORDERCOLOR = 12255232;
    };
   USER_PROPERTIES = 
    {
    };
   DOCUMENTATION = 
    {
    };
   PARENTS = (C_Oxigen);
   DEFINITION = 
    {
     NAMESTATES = (yes, no);
     PROBABILITIES = (0.10000000, 0.90000000, 0.00000000, 1.00000000);
    };
   EXTRA_DEFINITION = 
    {
     DIAGNOSIS_TYPE = TARGET;
     RANKED = TRUE;
     MANDATORY = FALSE;
     SETASDEFAULT = FALSE;
     SHOWAS = 4;
     FAULT_STATES = (1, 0);
     FAULT_NAMES = ("", "");
     FAULT_LABELS = ("F20", "F21");
     DEFAULT_STATE = 0;
     DOCUMENTATION = 
      {
      };
     DOCUMENTATION = 
      {
      };
     STATECOMMENTS = ("", "");
     STATEREPAIRINFO = ("", "");
     QUESTION = "";
    };
  };

 node C_ReacH
  {
   TYPE = NOISY_OR;
   HEADER = 
    {
     ID = C_ReacH;
     NAME = "C_ReacH";
     COMMENT = "";
    };
   SCREEN = 
    {
     POSITION = 
      {
       CENTER_X = 457;
       CENTER_Y = 235;
       WIDTH = 70;
       HEIGHT = 30;
      };
     COLOR = 16250597;
     SELCOLOR = 12303291;
     FONT = 1;
     FONTCOLOR = 0;
     BORDERTHICKNESS = 1;
     BORDERCOLOR = 12255232;
    };
   USER_PROPERTIES = 
    {
    };
   DOCUMENTATION = 
    {
    };
   PARENTS = (C_Hydrogen);
   DEFINITION = 
    {
     NAMESTATES = (yes, no);
     PROBABILITIES = (0.10000000, 0.90000000, 0.00000000, 1.00000000);
    };
   EXTRA_DEFINITION = 
    {
     DIAGNOSIS_TYPE = TARGET;
     RANKED = TRUE;
     MANDATORY = FALSE;
     SETASDEFAULT = FALSE;
     SHOWAS = 4;
     FAULT_STATES = (1, 0);
     FAULT_NAMES = ("", "");
     FAULT_LABELS = ("F22", "F23");
     DEFAULT_STATE = 0;
     DOCUMENTATION = 
      {
      };
     DOCUMENTATION = 
      {
      };
     STATECOMMENTS = ("", "");
     STATEREPAIRINFO = ("", "");
     QUESTION = "";
    };
  };

 node C_Sensor1
  {
   TYPE = CPT;
   HEADER = 
    {
     ID = C_Sensor1;
     NAME = "C_Sensor1";
     COMMENT = "";
    };
   SCREEN = 
    {
     POSITION = 
      {
       CENTER_X = 332;
       CENTER_Y = 220;
       WIDTH = 70;
       HEIGHT = 30;
      };
     COLOR = 16250597;
     SELCOLOR = 12303291;
     FONT = 1;
     FONTCOLOR = 0;
     BORDERTHICKNESS = 1;
     BORDERCOLOR = 12255232;
    };
   USER_PROPERTIES = 
    {
    };
   DOCUMENTATION = 
    {
    };
   PARENTS = (C_Oxigen, C_Hydrogen);
   DEFINITION = 
    {
     NAMESTATES = (on, off);
     PROBABILITIES = (0.90000000, 0.10000000, 0.10000000, 0.90000000, 
     0.10000000, 0.90000000, 0.90000000, 0.10000000);
    };
   EXTRA_DEFINITION = 
    {
     DIAGNOSIS_TYPE = AUXILIARY;
     RANKED = FALSE;
     MANDATORY = FALSE;
     SETASDEFAULT = FALSE;
     SHOWAS = 4;
     FAULT_STATES = (0, 0);
     FAULT_NAMES = ("", "");
     FAULT_LABELS = ("F24", "F25");
     DEFAULT_STATE = 0;
     DOCUMENTATION = 
      {
      };
     DOCUMENTATION = 
      {
      };
     STATECOMMENTS = ("", "");
     STATEREPAIRINFO = ("", "");
     QUESTION = "";
    };
  };

 node C_Sensor2
  {
   TYPE = CPT;
   HEADER = 
    {
     ID = C_Sensor2;
     NAME = "C_Sensor2";
     COMMENT = "";
    };
   SCREEN = 
    {
     POSITION = 
      {
       CENTER_X = 310;
       CENTER_Y = 281;
       WIDTH = 70;
       HEIGHT = 30;
      };
     COLOR = 16250597;
     SELCOLOR = 12303291;
     FONT = 1;
     FONTCOLOR = 0;
     BORDERTHICKNESS = 1;
     BORDERCOLOR = 12255232;
    };
   USER_PROPERTIES = 
    {
    };
   DOCUMENTATION = 
    {
    };
   PARENTS = (C_Oxigen);
   DEFINITION = 
    {
     NAMESTATES = (on, off);
     PROBABILITIES = (0.90000000, 0.10000000, 0.10000000, 0.90000000);
    };
   EXTRA_DEFINITION = 
    {
     DIAGNOSIS_TYPE = AUXILIARY;
     RANKED = FALSE;
     MANDATORY = FALSE;
     SETASDEFAULT = FALSE;
     SHOWAS = 4;
     FAULT_STATES = (0, 0);
     FAULT_NAMES = ("", "");
     FAULT_LABELS = ("F26", "F27");
     DEFAULT_STATE = 0;
     DOCUMENTATION = 
      {
      };
     DOCUMENTATION = 
      {
      };
     STATECOMMENTS = ("", "");
     STATEREPAIRINFO = ("", "");
     QUESTION = "";
    };
  };

 node C_Explosion
  {
   TYPE = CPT;
   HEADER = 
    {
     ID = C_Explosion;
     NAME = "C_Explosion";
     COMMENT = "";
    };
   SCREEN = 
    {
     POSITION = 
      {
       CENTER_X = 405;
       CENTER_Y = 283;
       WIDTH = 87;
       HEIGHT = 30;
      };
     COLOR = 16250597;
     SELCOLOR = 12303291;
     FONT = 1;
     FONTCOLOR = 0;
     BORDERTHICKNESS = 1;
     BORDERCOLOR = 12255232;
    };
   USER_PROPERTIES = 
    {
    };
   DOCUMENTATION = 
    {
    };
   PARENTS = (C_Oxigen, C_Hydrogen);
   DEFINITION = 
    {
     NAMESTATES = (yes, no);
     PROBABILITIES = (0.90000000, 0.10000000, 0.00000000, 1.00000000, 
     0.00000000, 1.00000000, 0.00000000, 1.00000000);
    };
   EXTRA_DEFINITION = 
    {
     DIAGNOSIS_TYPE = TARGET;
     RANKED = TRUE;
     MANDATORY = FALSE;
     SETASDEFAULT = FALSE;
     SHOWAS = 4;
     FAULT_STATES = (1, 0);
     FAULT_NAMES = ("", "");
     FAULT_LABELS = ("F28", "F29");
     DEFAULT_STATE = 0;
     DOCUMENTATION = 
      {
      };
     DOCUMENTATION = 
      {
      };
     STATECOMMENTS = ("", "");
     STATEREPAIRINFO = ("", "");
     QUESTION = "";
    };
  };
 OBSERVATION_COST = 
  {

   node Oxigen
    {
     PARENTS = ();
     COSTS = (0.00000000);
    };

   node Hydrogen
    {
     PARENTS = ();
     COSTS = (0.00000000);
    };

   node ReacO
    {
     PARENTS = ();
     COSTS = (0.00000000);
    };

   node ReacH
    {
     PARENTS = ();
     COSTS = (0.00000000);
    };

   node Sensor1
    {
     PARENTS = ();
     COSTS = (0.00000000);
    };

   node Explosion
    {
     PARENTS = ();
     COSTS = (0.00000000);
    };

   node Sensor2
    {
     PARENTS = ();
     COSTS = (0.00000000);
    };

   node C_Oxigen
    {
     PARENTS = ();
     COSTS = (0.00000000);
    };

   node C_Hydrogen
    {
     PARENTS = ();
     COSTS = (0.00000000);
    };

   node C_ReacO
    {
     PARENTS = ();
     COSTS = (0.00000000);
    };

   node C_ReacH
    {
     PARENTS = ();
     COSTS = (0.00000000);
    };

   node C_Sensor1
    {
     PARENTS = ();
     COSTS = (0.00000000);
    };

   node C_Sensor2
    {
     PARENTS = ();
     COSTS = (0.00000000);
    };

   node C_Explosion
    {
     PARENTS = ();
     COSTS = (0.00000000);
    };
  };
};
