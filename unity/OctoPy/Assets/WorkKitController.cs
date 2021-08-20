using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Android;
using System;
using UnityEngine.SceneManagement;
using static SpeechRecognizerPlugin;

public class WorkKitController : MonoBehaviour
{
    bool micActive;
    public Text staticDisplay;
    public Button mic;
    public String name;
    public Button forSound;
    public Image check;
    public Image wrong;
    private bool wrongf;
    private bool checkf;
    public Text score;
    public GameObject next;
    private SpeechRecognizerPlugin plugin = null;

    // Start is called before the first frame update
    void Start()
    {
      /*  gameObject.AddComponent<UnityMessageManager>();
        UnityMessageManager.Instance.SendMessageToFlutter("WordKit");*/
        plugin = SpeechRecognizerPlugin.GetPlatformPluginVersion(this.gameObject.name);
        mic.onClick.AddListener(startRecording);
        forSound.onClick.AddListener(makeSound);
        check.gameObject.SetActive(false);
        wrong.gameObject.SetActive(false);
    }
    public void FixedUpdate()
    {
        SoundManagerScript.playSound(name);
    }

    // Update is called once per frame
    void Update()
    {

        if (Application.platform == RuntimePlatform.Android)
        {
            if (Input.GetKey(KeyCode.Escape))
            {
                // Insert Code Here (I.E. Load Scene, Etc)
                // OR Application.Quit();
                SceneManager.LoadScene("Homescreen");
                return;
            }
        }
    }
    public void makeSound()
    {
        if (name.Equals("dog"))
        {
            SoundManagerScript.doghasPlayed = false;
        }
       else if (name.Equals("duck"))
        {
            SoundManagerScript.duckhasPlayed = false;
        }
        else if (name.Equals("goat"))
        {
            SoundManagerScript.goathasPlayed = false;
        }
        SoundManagerScript.playSound(name);
    }
    void startRecording()
    {
        check.gameObject.SetActive(false);
        wrong.gameObject.SetActive(false);
        checkf = false;
        wrongf = false;
        if (micActive)
        {
            StopListening();
            micActive = false;
        }
        else
        {
            StartListening();
            micActive = true;
        }
        

    }

    private void StartListening()
    {
        plugin.StartListening();
    }

    private void StopListening()
    {
        plugin.StopListening();
    }
    public void OnResult(string recognizedResult)
    {
        char[] delimiterChars = { '~' };
        string[] results = recognizedResult.Split(delimiterChars);

/*        resultsTxt.text = "";
*/        /* for (int i = 0; i < result.Length; i++)
         {
             resultsTxt.text += result[i] + '\n';
         }*/
       // resultsTxt.text += results[0];
        string result  = results[0];

        staticDisplay.text = result;
        if (result.Equals(this.name))
        {
            check.gameObject.SetActive(true);
            checkf = true;
            if (wrongf)
            {
                wrong.gameObject.SetActive(false);
            }
            int number = Int32.Parse(score.text.ToString()) + 5;
            score.text = number.ToString();
            SoundManagerScript.playSound("answerCorrect");
            StartCoroutine(ExecuteAfterTime(1.0f));
        }
        else
        {
            wrong.gameObject.SetActive(true);
            wrongf = true;
            if (checkf)
            {
                check.gameObject.SetActive(false);
            }
            SoundManagerScript.playSound("answerWrong");
        }
    }
    IEnumerator ExecuteAfterTime(float time)
    {
        yield return new WaitForSeconds(time);
        staticDisplay.text = "Tap the mic to answer";
        this.gameObject.SetActive(false);
        check.gameObject.SetActive(false);
        wrong.gameObject.SetActive(false);
        checkf = false;
        wrongf = false;
        next.gameObject.SetActive(true);

    }

}
