using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class SoundManager : MonoBehaviour
{
    [SerializeField] Image soundOnIcon; //for variable to be private but also show up in the editor
    [SerializeField] Image soundOffIcon;
    private bool muted = false;

    // Start is called before the first frame update
    void Start()
    {
        if(!PlayerPrefs.HasKey("muted"))
        {
            PlayerPrefs.SetInt("muted", 0);
            Load();

        }
        else
        {
            Load();

        }
        UpdateButtonIcon();
        AudioListener.pause = muted;
    }

    public void OnButtonPress()
    {
        if (muted == false)
        {
            muted = true;
            AudioListener.pause = true;
        }
        else
        {
            muted = false;
            AudioListener.pause = false;

        }
        Save();
        UpdateButtonIcon();
    }

    private void UpdateButtonIcon()
    {
        if (muted == false)
        {
            soundOnIcon.enabled = true;
            soundOffIcon.enabled = false;
        }
        else
        {
            soundOnIcon.enabled = false;
            soundOffIcon.enabled = true;

        }

    }
    private void Load()
    {
        muted = PlayerPrefs.GetInt("muted") == 1; //if muted is 1, muted is set to true and vice versa
    }

    private void Save() //set data & convert bool to int
    {
        PlayerPrefs.SetInt("muted", muted ? 1 : 0); //if muted is true, save it as 1, else save it as 0 
    }

}
