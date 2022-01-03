using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class SoundManagerScript: MonoBehaviour
{
    public static AudioClip buttonsound, correctSound, wrongSound, homescreenSound, dogSound, cowSound, catSound;
    static AudioSource audioSrc;
    public Toggle m_Toggle;
    static bool hasPlayed = false;
    public static bool doghasPlayed = false;
    public static bool cowhasPlayed = false;
    public static bool cathasPlayed = false;
    // Start is called before the first frame update
    void Start()
    {
        wrongSound = Resources.Load<AudioClip>("answerWrong");
        buttonsound = Resources.Load<AudioClip>("buttonSound");
        correctSound = Resources.Load<AudioClip>("answerCorrect");
        homescreenSound = Resources.Load<AudioClip>("Homescreen");
        dogSound = Resources.Load<AudioClip>("dog");
        cowSound = Resources.Load<AudioClip>("cow");
        catSound = Resources.Load<AudioClip>("cat");
        // DontDestroyOnLoad(transform.gameObject);
        audioSrc = GetComponent<AudioSource>();
   
    }

    // Update is called once per frame
    void Update()
    {

    }
    public static void playSound(string filename)
    {
      
        switch (filename)
        {
            case "buttonSound":
                audioSrc.PlayOneShot(buttonsound);
                break;
            case "answerCorrect":
                audioSrc.PlayOneShot(correctSound);
                break;
            case "answerWrong":
                audioSrc.PlayOneShot(wrongSound);
                break;
            case "Homescreen":
                if (!hasPlayed)
                {
                    audioSrc.PlayOneShot(homescreenSound);
                    hasPlayed = true;
                }
                break;
            case "dog":
                if (!doghasPlayed)
                {
                    audioSrc.PlayOneShot(dogSound);
                    doghasPlayed = true;
                }
                break;
            case "cow":
                if (!cowhasPlayed)
                {
                    audioSrc.PlayOneShot(cowSound);
                    cowhasPlayed = true;
                }
                break;
            case "cat":
                if (!cathasPlayed)
                {
                    audioSrc.PlayOneShot(catSound);
                    cathasPlayed = true;
                }
                break;
        }
       
    }
}
