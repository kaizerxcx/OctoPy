using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Android;
using TextSpeech;
using System;
using UnityEngine.SceneManagement;
public class WorkKitController : MonoBehaviour
{
    const string LANG_CODE = "en-US";
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
    // Start is called before the first frame update
    void Start()
    {
        setUp(LANG_CODE);
#if UNITY_ANDROID
        SpeechToText.instance.onPartialResultsCallback = OnFinalPartialSpeechResult;
#endif
        SpeechToText.instance.onResultCallback = OnFinalSpeechResult;

        TextToSpeech.instance.onStartCallBack = onSpeakStart;
        TextToSpeech.instance.onDoneCallback = onSpeakStop;
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
            stopListening();
            micActive = false;
        }
        else
        {
            startListening();
            micActive = true;
        }
        

    }

    void checkPermision()
    {
#if UNITY_ANDROID
        if (!Permission.HasUserAuthorizedPermission(Permission.Microphone))
        {
            Permission.RequestUserPermission(Permission.Microphone);
        }
#endif
    }
    #region Text To Speech
    public void startSpeaking(string message)
    {
        TextToSpeech.instance.StartSpeak(message);
    }
    public void stopSpeaking()
    {
        TextToSpeech.instance.StopSpeak();
    }
    void onSpeakStart()
    {
        Debug.Log("Talking Started");
    }
    void onSpeakStop()
    {
        Debug.Log("Talking Stopped");
    }
    #endregion

    #region Speech To Text
    public void startListening()
    {
        SpeechToText.instance.StartRecording();
        staticDisplay.text = "Listening...";
    }
    public void stopListening()
    {
        SpeechToText.instance.StopRecording();
        staticDisplay.text = "Recording stopped";
    }
    void OnFinalSpeechResult(string result)
    {
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
    void OnFinalPartialSpeechResult(string result)
    {
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
    #endregion
    void setUp(string code)
    {
        TextToSpeech.instance.Setting(code, 1, 1);
        SpeechToText.instance.Setting(code);
    }
}
