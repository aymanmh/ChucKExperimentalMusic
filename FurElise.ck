//simple Fur Elise

//will choose a percution flute
PercFlut myFlute => dac;
//Use one octave higher than middle C: C5,D5,etc...
440.0 => float A4;
getNoteFreq(2) => float B4;
getNoteFreq(3) => float C5;
getNoteFreq(5) => float D5;
getNoteFreq(6) => float Ds5; //s= sharp, can't use the # in the variable's name
getNoteFreq(7) => float E5;
getNoteFreq(8) => float F5;
//this a simplified version of Fur Elise, i divided the melody into three sections:
[ E5, Ds5, E5,Ds5, E5, B4,D5,C5,A4 ] @=> float FurEliseScoreMelody1[];
[ A4,A4,A4,B4,B4, B4,B4,C5] @=> float FurEliseScoreMelody2[];
[ A4,A4,A4,B4,B4,C5,B4,A4,B4,C5,D5,E5, E5,F5,E5,D5, D5,E5,D5,C5, C5,D5,C5,B4] @=> float FurEliseScoreMelody3[];

0 => int i;
0.8 => float velocity; //defines how loud the note is.
0.0 => float riseFactor;//use this to make the sound rise in the first section below
for ( i ; i < 9; 1 +=> i )
{
    i/20.0 => riseFactor;
    FurEliseScoreMelody1[i] => myFlute.freq;
    if(i == 8) //last note is longer
    {
        myFlute.noteOn(velocity/2.0 + riseFactor);
        600::ms=> now;
    }
    else
    {
        myFlute.noteOn(velocity/2.0 + riseFactor);
        300::ms=> now;
    }
}

0 => i;
for ( i ; i < 8; 1 +=> i )
{
    FurEliseScoreMelody2[i] => myFlute.freq;

    if(i == 3 || i == 7) //play these note longer
    {        
        myFlute.noteOn(velocity);
        900::ms=> now;
    }
    else 
    {
        myFlute.noteOn(velocity);
        300::ms=> now;
    }
}
0 => i;
for ( i ; i < 9; 1 +=> i )
{
    FurEliseScoreMelody1[i] => myFlute.freq;
    if(i == 8) //last note is longer
    {
        myFlute.noteOn(velocity);
        600::ms=> now;
    }
    else
    {
        myFlute.noteOn(velocity);
        300::ms=> now;
    }
}

0 => i;
for ( i ; i < 24; 1 +=> i )
{
    FurEliseScoreMelody3[i] => myFlute.freq;
  
     if(i == 3 || i==7 || i==11 || i == 15 || i==19 || i==23) //play the 8th & 15th notes longer
    {       
        myFlute.noteOn(velocity);
        900::ms=> now;
    }
    else 
    {
        myFlute.noteOn(velocity);
        300::ms=> now;
    }
}

0 => i;
0.0 => float fadeFactor; //will use this to make the sound fade away in the last part
for ( i ; i < 9; 1 +=> i )
{
    i/20.0 => fadeFactor;
    //<<<fadeFactor>>>;
    FurEliseScoreMelody1[i] => myFlute.freq;
    if(i == 8) //last note is longer
    {
        myFlute.noteOn(velocity - fadeFactor );
        1500::ms=> now;
    }
    else
    {
        myFlute.noteOn(velocity - fadeFactor);
        400::ms=> now; //slower this time,
    }
}

//generate the ntoes frequency
fun float getNoteFreq(float halfSteps )
{
/* follow this formula to get the note's frequency:
fn = f0 * (a)power n 
where
f0 = the frequency of one fixed note which must be defined. A common choice is setting the A above middle C (A4) at f0 = 440 Hz.
n = the number of half steps away from the fixed note you are. If you are at a higher note, n is positive. If you are on a lower note, n is negative.
fn = the frequency of the note n half steps away.
a = (2)1/12 = the twelfth root of 2 = the number which when multiplied by itself 12 times equals 2 = 1.059463094359... 
*/
    // set the A above middle C  A4=440.0Hz
    440.0 => float A4;
    A4 => float f0;
    2.0,1.0/12.0 => float n;
    Math.pow(2.0,n)  => float a;
    
    f0 * Math.pow(a,halfSteps) => float result;
    
    return result;
}
