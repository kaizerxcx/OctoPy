using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class SoundManagerScript: MonoBehaviour
{
    public static AudioClip buttonsound, correctSound, wrongSound, homescreenSound, dogSound, duckSound, goatSound;
    static AudioSource audioSrc;
    public Toggle m_Toggle;
    static bool hasPlayed = false;
    public static bool doghasPlayed = false;
    public static bool duckhasPlayed = false;
    public static bool goathasPlayed = false;
    // Start is called before the first frame update
    void Start()
    {
        wrongSound = Resources.Load<AudioClip>("answerWrong");
        buttonsound = Resources.Load<AudioClip>("buttonSound");
        correctSound = Resources.Load<AudioClip>("answerCorrect");
        homescreenSound = Resources.Load<AudioClip>("Homescreen");
        dogSound = Resources.Load<AudioClip>("dog");
        duckSound = Resources.Load<AudioClip>("duck");
        goatSound = Resources.Load<AudioClip>("goat");
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
            case "duck":
                if (!duckhasPlayed)
                {
                    audioSrc.PlayOneShot(duckSound);
                    duckhasPlayed = true;
                }
                break;
            case "goat":
                if (!goathasPlayed)
                {
                    audioSrc.PlayOneShot(goatSound);
                    goathasPlayed = true;
                }
                break;
        }
       
    }
}
