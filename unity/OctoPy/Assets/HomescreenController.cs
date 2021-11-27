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
    public TextMeshProUGUI fronttext;
    public GameObject WordKitLock;
    private int i = 0;
    private string flutterMessage = "";
    private UnityMessageManager unitymanager;

    void Start()
    {
       /* gameObject.AddComponent<UnityMessageManager>();
        UnityMessageManager.Instance.SendMessageToFlutter("HomeScreen");*/
        crazeOnPhonics.onClick.AddListener(startCraze);
        wordKit.onClick.AddListener(startWord);
        readingSpree.onClick.AddListener(startReading);
        mazeCraze.onClick.AddListener(startMazeCraze);
        unitymanager = GetComponent<UnityMessageManager>();

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
        SceneManager.LoadScene("CrazeOnPhonics");
    }
    public void startWord()
    {
        SceneManager.LoadScene("WordKit");
    }
    public void startReading()
    {
        SceneManager.LoadScene("ReadingSpree");
    }
    public void startMazeCraze()
    {
        SceneManager.LoadScene("MazeCraze");
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
