using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Android;
using System;
using UnityEngine.SceneManagement;

public class SeqLast : MonoBehaviour
{
    const string LANG_CODE = "en-US";
    public Text score;
    public string question;
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
        //  nextCanvas.SetActive(true);
        SceneManager.LoadScene("WordKit");
    }







   
}
