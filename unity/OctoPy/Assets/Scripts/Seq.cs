using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Android;
using System;
using UnityEngine.SceneManagement;

public class Seq : MonoBehaviour
{
    const string LANG_CODE = "en-US";
    public Text score;
    public string question;
    public GameObject nextCanvas;
    public Button speaker;
    public Button buttonCorrect;
    public Button buttonWrong;
    public Image check;
    public Image wrong;
    private bool wrongf;
    private bool checkf;

    // Start is called before the first frame update
    void Start()
    {
        /*     setUp(LANG_CODE);
     #if UNITY_ANDROID
             SpeechToText.instance.onPartialResultsCallback = OnFinalPartialSpeechResult;
     #endif
             SpeechToText.instance.onResultCallback = OnFinalSpeechResult;

             TextToSpeech.instance.onStartCallBack = onSpeakStart;
             TextToSpeech.instance.onDoneCallback = onSpeakStop;

             checkPermision();*/
       /* gameObject.AddComponent<UnityMessageManager>();
        UnityMessageManager.Instance.SendMessageToFlutter("CrazeOnPhonics");*/

        speaker.onClick.AddListener(pressSpeak);
        buttonCorrect.onClick.AddListener(showCheck);
        buttonWrong.onClick.AddListener(showWrong);
        check.gameObject.SetActive(false);
        wrong.gameObject.SetActive(false);
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

    public void pressSpeak() {
        /* startSpeaking(question);*/
        TTSManager.SetLocale("en");
        TTSManager.Speak(question);
    }
    public void showCheck()
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
        StartCoroutine(ExecuteAfterTime(0.1f));
     
    }
    public void showWrong()
    {
        wrong.gameObject.SetActive(true);
        wrongf = true;
        if (checkf)
        {
            check.gameObject.SetActive(false);
        }
        SoundManagerScript.playSound("answerWrong");
    }

    IEnumerator ExecuteAfterTime(float time)
    {
        int i=0;
        Debug.Log(" " + i++);
        yield return new WaitForSeconds(time);
        check.gameObject.SetActive(false);
        wrong.gameObject.SetActive(false);
        this.gameObject.SetActive(false);
        nextCanvas.SetActive(true);
    }







   /* void checkPermision()
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
    }
    public void stopListening()
    {
        SpeechToText.instance.StopRecording();

    }
    void OnFinalSpeechResult(string result)
    {
       

    }
    void OnFinalPartialSpeechResult(string result)
    {
        
    }
    #endregion
    void setUp(string code)
    {
        TextToSpeech.instance.Setting(code, 1, 1);
        SpeechToText.instance.Setting(code);
    }*/
}
