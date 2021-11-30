using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;
using TMPro;

public class HomescreenController : MonoBehaviour
{
    // Start is called before the first frame update
    public Button crazeOnPhonics;
    public Button wordKit;
    public Button readingSpree;
    public Button mazeCraze;
    public Button alphaHopper;
    public TextMeshProUGUI fronttext;
    public GameObject WordKitLock;
    private int i = 0;
    private string flutterMessage = "-1";
    private UnityMessageManager unitymanager;
    void Start()
    {
       /* gameObject.AddComponent<UnityMessageManager>();
        UnityMessageManager.Instance.SendMessageToFlutter("HomeScreen");*/

        crazeOnPhonics.onClick.AddListener(startCraze);
        wordKit.onClick.AddListener(startWord);
        readingSpree.onClick.AddListener(startReading);
        mazeCraze.onClick.AddListener(startMazeCraze);
        alphaHopper.onClick.AddListener(startAlphaHopper);
        unitymanager = GetComponent<UnityMessageManager>();
        Screen.orientation = ScreenOrientation.Portrait;

        AudioListener.pause = false;
        PlayerPrefs.SetInt("muted", 0);
    }

    private void FixedUpdate()
    {
        unitymanager.SendMessageToFlutter("getUserInfo");

        SoundManagerScript.playSound("Homescreen");
        StartCoroutine(ExecuteAfterTime(0.1f));
       
        if (i > 27)
        {
            WordKitLock.SetActive(true);
            wordKit.interactable = false;
        }
        SessionManager.user_id = int.Parse(flutterMessage);
        fronttext.SetText(" " + flutterMessage);
       
    }
    public void getUserInfo(string message)
    {
        flutterMessage = message;
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
                Application.Quit();
                return;
            }
        }
    }
    public void startCraze()
    {
        Screen.orientation = ScreenOrientation.AutoRotation;
        SceneManager.LoadScene("CrazeOnPhonics");
    }
    public void startWord()
    {
        Screen.orientation = ScreenOrientation.AutoRotation;
        SceneManager.LoadScene("WordKit");
    }
    public void startReading()
    {
        Screen.orientation = ScreenOrientation.AutoRotation;
        SceneManager.LoadScene("ReadingSpree");
    }
    public void startMazeCraze()
    {
        SceneManager.LoadScene("MazeCraze");
    }
    public void startAlphaHopper()
    {
        Screen.orientation = ScreenOrientation.AutoRotation;
        SceneManager.LoadScene("Consonant1");
    }
    /*  public int GetSDKLevel()
      {
          var clazz = AndroidJNI.FindClass("android.os.Build$VERSION");
          var fieldID = AndroidJNI.GetStaticFieldID(clazz, "SDK_INT", "I");
          var sdkLevel = AndroidJNI.GetStaticIntField(clazz, fieldID);
          return sdkLevel;
      }*/
    IEnumerator ExecuteAfterTime(float time)
    {
        var clazz = AndroidJNI.FindClass("android/os/Build$VERSION");
        var fieldID = AndroidJNI.GetStaticFieldID(clazz, "SDK_INT", "I");
        var sdkLevel = AndroidJNI.GetStaticIntField(clazz, fieldID);
        i = sdkLevel;
        yield return new WaitForSeconds(time);
    }

}
